import unittest

from unittest.mock import patch, Mock

import os
import sys

# Adicione o caminho para o diretório que contém lambda_function.py ao Python PATH
sys.path.append(os.path.dirname(os.path.abspath(__file__)) + '/../')

from lambda_function import lambda_handler


class TestLambdaFunction(unittest.TestCase):

    @patch('boto3.client')
    def test_lambda_success(self, mock_boto3_client):
        mock_sqs_client = Mock()
        mock_boto3_client.return_value = mock_sqs_client
        mock_sqs_client.send_message.return_value = {'MessageId': 'test-id'}

        result = lambda_handler(getEvent(), None)
        self.assertEqual(result['statusCode'], 200)
        self.assertEqual(result['body'], '{"id": "1", "name": "Gui"}')

# getEvent should return a dynamo streams event
def getEvent(): return {
    "Records": [
        {
            "eventID": "1",
            "eventVersion": "1.0",
            "dynamodb": {
                "keys": {
                    "id": {
                        "N": "1"
                    }
                },
                "NewImage": {
                    "id": {
                        "S": "1"
                    },
                    "name": {
                        "S": "Gui"
                    }
                },
                "SequenceNumber": "111",
                "SizeBytes": 22,
                "StreamViewType": "NEW_AND_OLD_IMAGES"
            },
            "awsRegion": "us-east-1",
            "eventName": "INSERT",
            "eventSourceARN": "000000000000000000000000000000000000000:table/test/stream/2015-06-27T00:48:05.899",
            "eventSource": "aws:dynamodb"
        }
    ]
}


if __name__ == '__main__':
    unittest.main()
