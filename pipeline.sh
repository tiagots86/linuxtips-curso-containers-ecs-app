#!/bin/bash

# Setup Inicial
set -e

AWS_ACCOUNT="481768428259"
export AWS_PAGER=""
export APP_NAME="linuxtips-app"



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

echo "Terraform - Format Check"

terraform fmt --recursive --check

echo "Terraform - Validate"

terraform validate

# Build App

# Publish App

# Apply do Terraform - CD