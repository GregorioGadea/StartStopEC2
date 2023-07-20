# Recurso para criar a função Lambda "start_ec2_lambda_function".
resource "aws_lambda_function" "lambda_function_start" {
  filename      = "start_ec2.zip" # Nome do arquivo ZIP contendo o código da função start_ec2.py
  function_name = "start_ec2_lambda_function"
  role          = aws_iam_role.lambda_role_start.arn
  handler       = "start_ec2.lambda_handler"
  runtime       = "python3.8"

  # Configuração do ambiente da função Lambda
  environment {
    variables = {
      region    = var.aws_region  # Usando a variável para a região da AWS
      instances = var.instance_id  # Usando a variável para o ID da instância
    }
  }
}

# Recurso para criar a função Lambda "stop_ec2_lambda_function".
resource "aws_lambda_function" "lambda_function_stop" {
  filename      = "stop_ec2.zip" # Nome do arquivo ZIP contendo o código da função stop_ec2.py
  function_name = "stop_ec2_lambda_function"
  role          = aws_iam_role.lambda_role_stop.arn
  handler       = "stop_ec2.lambda_handler"
  runtime       = "python3.8"

  # Configuração do ambiente da função Lambda
  environment {
    variables = {
      region    = var.aws_region  # Usando a variável para a região da AWS
      instances = var.instance_id  # Usando a variável para o ID da instância
    }
  }
}

# Recurso para criar os arquivos ZIP com os códigos das funções Lambda "start_ec2" e "stop_ec2".
data "archive_file" "lambda_code_start" {
  type        = "zip"
  source_file = "start_ec2.py" # Nome do arquivo que contém o código da função start_ec2.py
  output_path = "start_ec2.zip"
}

data "archive_file" "lambda_code_stop" {
  type        = "zip"
  source_file = "stop_ec2.py" # Nome do arquivo que contém o código da função stop_ec2.py
  output_path = "stop_ec2.zip"
}

# Recurso para criar a regra do EventBridge para agendar a execução da função "start_ec2_lambda_function".
resource "aws_cloudwatch_event_rule" "start_ec2_rule" {
  name        = "start_ec2_rule"
  description = "Rule to trigger start_ec2_lambda_function"

  # Expressão cron para agendar a execução da função Lambda todos os dias às 08:00 UTC.
  schedule_expression = var.aws_cron_start
}

# Recurso para criar a regra do EventBridge para agendar a execução da função "stop_ec2_lambda_function".
resource "aws_cloudwatch_event_rule" "stop_ec2_rule" {
  name        = "stop_ec2_rule"
  description = "Rule to trigger stop_ec2_lambda_function"

  # Expressão cron para agendar a execução da função Lambda todos os dias às 20:00 UTC.
  schedule_expression = var.aws_cron_stop
}

# Recurso para conceder permissões ao EventBridge para acionar a função "start_ec2_lambda_function".
resource "aws_lambda_permission" "start_ec2_permission" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function_start.arn
  principal     = "events.amazonaws.com"
}

# Recurso para conceder permissões ao EventBridge para acionar a função "stop_ec2_lambda_function".
resource "aws_lambda_permission" "stop_ec2_permission" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function_stop.arn
  principal     = "events.amazonaws.com"
}

# Recurso para associar a regra do EventBridge com a função "start_ec2_lambda_function".
resource "aws_cloudwatch_event_target" "start_ec2_target" {
  rule      = aws_cloudwatch_event_rule.start_ec2_rule.name
  arn       = aws_lambda_function.lambda_function_start.arn
}

# Recurso para associar a regra do EventBridge com a função "stop_ec2_lambda_function".
resource "aws_cloudwatch_event_target" "stop_ec2_target" {
  rule      = aws_cloudwatch_event_rule.stop_ec2_rule.name
  arn       = aws_lambda_function.lambda_function_stop.arn
}
