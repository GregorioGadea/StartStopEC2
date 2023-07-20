Repo criado com o intuito de criar uma automação Terraform para aplicar o Start/Stop em uma instância AWS.


Como é feito o Start/Stop manualmente: 👇🏻

Primeiro passo:
 - Criar um código StartEC2/StopEC2 Lambda com boto3 e python 3.9

Segundo Passo:
 - Atribuir estes códigos a uma schedule dentro do EventBridge.

Código Start EC2:
-------------------------------------------------------------
import boto3
region = 'sa-east-1' <---- Região da máquina
instances = ['i-0ab42e1ed37f12ead']   <---- ID da instância
ec2 = boto3.client('ec2', region_name=region)

def lambda_handler(event, context):
    ec2.start_instances(InstanceIds=instances)
    print('started your instances: ' + str(instances))
--------------------------------------------------------------
Código Stop EC2:                                             
--------------------------------------------------------------
import boto3
region = 'sa-east-1'
instances = ['i-0ab42e1ed37f12ead']
ec2 = boto3.client('ec2', region_name=region)

def lambda_handler(event, context):
    ec2.stop_instances(InstanceIds=instances)
    print('stopped your instances: ' + str(instances))
--------------------------------------------------------------

Automação Terraform 👇🏻

Para a automação funcionar é necessário criar um start_ec2.py.zip/stop_ec2.py.zip (NÃO apagar os arquivos python não zipados)
após configurar o id da instância nos arquivos .py .

Para setar a instância, região e cron dentro do Terraform basta atualizar as variaveis no arquivo terrafrom "variables.tf"
