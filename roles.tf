#----- ROLES LAMBDA --------#

# Recurso para criar o papel do IAM para a função Lambda "start_ec2_lambda_function".
resource "aws_iam_role" "lambda_role_start" {
  name = "lambda_execution_role_start"

  # Definindo a política de permissão para permitir que o serviço Lambda assuma esse papel.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Recurso para criar o papel do IAM para a função Lambda "stop_ec2_lambda_function".
resource "aws_iam_role" "lambda_role_stop" {
  name = "lambda_execution_role_stop"

  # Definindo a política de permissão para permitir que o serviço Lambda assuma esse papel.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}
