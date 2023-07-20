import boto3

region = 'sa-east-1' # <-- Região da instância e função lambda
instances = ['i-032c4ba893d9c1075'] # <--- ID da instância EC2
ec2 = boto3.client('ec2', region_name=region)

def lambda_handler(event, context):
    ec2.stop_instances(InstanceIds=instances)
    print('stopped your instances: ' + str(instances))