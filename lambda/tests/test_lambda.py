import unittest

from unittest.mock import patch, Mock
from lambda_function import lambda_handler


class TestLambdaFunction(unittest.TestCase):

    @patch('lambda_function.queue')
    def test_lambda_success(self, mock_queue_service):
        mock_queue = Mock()
        mock_queue_service.return_value = mock_queue
        mock_queue_service.send.return_value = {'MessageId': 'test-id'}

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
