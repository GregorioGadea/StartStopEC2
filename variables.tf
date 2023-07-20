# Variável para o ID da instância EC2

variable "instance_id" {
  type    = string
  default = "i-032c4ba893d9c1075" # ID da instância padrão, você pode alterar conforme necessário
}

# Variável para a região da AWS

variable "aws_region" {
  type    = string
  default = "us-east-1" # Região padrão, você pode alterar conforme necessário
}


variable "aws_cron_start" {
  type = string
  default = "cron(52 10 ? * MON-FRI *)"
}

variable "aws_cron_stop" {
  type = string
  default = "cron(30 21 ? * MON-FRI *)"
}
