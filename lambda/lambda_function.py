from src import dynamo_event_handler
from src import queue


def lambda_handler(event, context):
    try:
        result = dynamo_event_handler.execute(event)
        queue.send(result)
        return {
            'statusCode': 200,
            'body': result
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': f'Erro: {str(e)}'
        }
