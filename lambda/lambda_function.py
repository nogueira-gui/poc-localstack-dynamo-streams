import json
from src import processor
from src import queue


def lambda_handler(event, context):
    try:
        result = processor.execute(event)
        queue.send(result)
        return {
            'statusCode': 200,
            'body': result
        }
    except Exception as e:
        print('erro: ', e)
        return {
            'statusCode': 500,
            'body': f'Erro: {str(e)}'
        }
