import boto3

region = 'sa-east-1' # <------- Região da instância EC2
instances = ['i-032c4ba893d9c1075'] # <------- ID da instância EC2
ec2 = boto3.client('ec2', region_name=region)

def lambda_handler(event, context):
    ec2.start_instances(InstanceIds=instances)
    print('started your instances: ' + str(instances))