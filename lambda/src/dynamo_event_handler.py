import json


def execute(event):
    try:
        for record in event['Records']:
            if record['eventName'] == 'INSERT':
                newImage = record['dynamodb']['NewImage']
                id = newImage['id']['S']
                name = newImage['name']['S']
                message = {
                    'id': id,
                    'name': name
                }
                return json.dumps(message)
    except Exception as e:
        raise e
