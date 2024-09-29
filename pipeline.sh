#!/bin/bash

# Setup Inicial
set -e

AWS_ACCOUNT="481768428259"
export AWS_PAGER=""
export APP_NAME="linuxtips-app"
export CLUSTER_NAME="linuxtips-cluster-ecs"
export BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

# CI da App

echo "APP - CI"

cd app/

echo "APP - LINT"

go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.61.0
golangci-lint run ./... -E errcheck

echo "APP - Test"

go test -v ./...

# CI do Terraform

echo "Terraform - CI"

cd ../terraform

echo "Deploy - Terraform init"

terraform init -backend-config=environment/$BRANCH_NAME/backend.tfvars

echo "Terraform - Format Check"

terraform fmt --recursive

echo "Terraform - Validate"

terraform validate

# Build App

echo "Build - App"

cd ../app

echo "Build - Bump de versao"

GIT_COMMIT_HASH=$(git rev-parse --short HEAD)
echo $GIT_COMMIT_HASH

echo "Build - Login no ECR"

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $AWS_ACCOUNT.dkr.ecr.us-east-1.amazonaws.com

echo "BUILD - CREATE ECR IF NOT EXISTS"

REPOSITORY_NAME="linuxtips/$APP_NAME"

set +e

# Verificar se o repositório já existe
REPO_EXISTS=$(aws ecr describe-repositories --repository-names $REPOSITORY_NAME 2>&1)

if [[ $REPO_EXISTS == *"RepositoryNotFoundException"* ]]; then
  echo "Repositório $REPOSITORY_NAME não encontrado. Criando..."
  
  # Criar o repositório
  aws ecr create-repository --repository-name $REPOSITORY_NAME
  
  if [ $? -eq 0 ]; then
    echo "Repositório $REPOSITORY_NAME criado com sucesso."
  else
    echo "Falha ao criar o repositório $REPOSITORY_NAME."
    exit 1
  fi
else
  echo "Repositório $REPOSITORY_NAME já existe."
fi

set -e

echo "Build - Docker Build"

docker build -t app . 

docker tag app:latest $AWS_ACCOUNT.dkr.ecr.us-east-1.amazonaws.com/$REPOSITORY_NAME:$GIT_COMMIT_HASH

# Publish App

echo "Build - Docker publish"

docker push $AWS_ACCOUNT.dkr.ecr.us-east-1.amazonaws.com/$REPOSITORY_NAME:$GIT_COMMIT_HASH

# Apply do Terraform - CD

cd ../terraform

REPOSITORY_TAG=$AWS_ACCOUNT.dkr.ecr.us-east-1.amazonaws.com/$REPOSITORY_NAME:$GIT_COMMIT_HASH

echo "Deploy - Terraform Plan"

terraform plan -var-file=environment/$BRANCH_NAME/terraform.tfvars

echo "Deploy - Terraform Apply"

terraform apply --auto-approve -var-file=environment/$BRANCH_NAME/terraform.tfvars

echo "Deploy - Wait Deploy"

aws ecs wait services-stable --cluster $CLUSTER_NAME --services $APP_NAME