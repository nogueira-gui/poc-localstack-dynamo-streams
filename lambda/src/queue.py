import boto3


def send(message):
    try:
        sqs = boto3.client('sqs',
                           aws_access_key_id='my_access_key',
                           aws_secret_access_key='my_secret_key',
                           region_name='us-east-1',
                           endpoint_url='http://localstack:4566')
        sqs.send_message(QueueUrl='http://localstack:4566/000000000000/test-queue',
                         MessageBody=message)
    except Exception as e:
        raise e
