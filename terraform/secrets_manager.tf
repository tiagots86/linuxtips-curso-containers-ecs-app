resource "aws_secretsmanager_secret" "teste2" {
  name = format("%s-secret-teste2", var.service_name)
}

resource "aws_secretsmanager_secret_version" "teste2" {
  secret_id     = aws_secretsmanager_secret.teste2.id
  secret_string = "Vim lá do Secrets Manager"
}