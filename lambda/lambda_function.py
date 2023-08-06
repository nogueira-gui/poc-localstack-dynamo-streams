import json
import boto3

s3 = boto3.client('s3', 
                  aws_access_key_id='my_access_key', 
                  aws_secret_access_key='my_secret_key',
                  region_name='us-east-1',
                  endpoint_url='http://localstack:4566')
                #   endpoint_url='http://localhost:4566')
def lambda_handler(event, context):
    s3_bucket = 'bucket-exam-files'
    s3_file_key = event.get('file_key')

    try:
        response = s3.get_object(Bucket=s3_bucket, Key=s3_file_key)
        file_content = response['Body'].read()
        parsed_content = json.loads(file_content)
        print(json.dumps(parsed_content))
        return {
            'statusCode': 200,
            'body': json.dumps(parsed_content)
        }
    except Exception as e:
        print('erro: ',e)
        return {
            'statusCode': 500,
            'body': f'Erro ao buscar o arquivo no S3: {str(e)}'
        }