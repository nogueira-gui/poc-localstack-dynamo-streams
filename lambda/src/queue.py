#write a code to send a message to a queue

import boto3
import os

isProd = os.environ.get('ENVIRONMENT') != 'localstack'

def send(message):

    if isProd:
        sqs = boto3.resource('sqs')
        print('Using AWS')
    else:
        sqs = boto3.client('sqs',
                        aws_access_key_id='my_access_key',
                        aws_secret_access_key='my_secret_key',
                        region_name='us-east-1',
                        endpoint_url='http://localstack:4566')
        print('Using localstack')
    
    response = sqs.send_message(
        QueueUrl=os.environ.get('QUEUE_URL'),
        MessageBody=message)

    print(response.get('MessageId'))


