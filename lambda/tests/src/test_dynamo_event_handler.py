import unittest
from src.dynamo_event_handler import execute


class TestDynamoDBEventHandler(unittest.TestCase):

    def test_execute_insert_event(self):
        event = {
            'Records': [
                {
                    'eventName': 'INSERT',
                    'dynamodb': {
                        'NewImage': {
                            'id': {'S': '123'},
                            'name': {'S': 'John Doe'}
                        }
                    }
                }
            ]
        }

        result = execute(event)

        expected_result = '{"id": "123", "name": "John Doe"}'
        self.assertEqual(result, expected_result)

    def test_execute_non_insert_event(self):
        event = {
            'Records': [
                {
                    'eventName': 'MODIFY',
                    'dynamodb': {
                        'NewImage': {
                            'id': {'S': '456'},
                            'name': {'S': 'Jane Doe'}
                        }
                    }
                }
            ]
        }

        result = execute(event)

        self.assertIsNone(result)


if __name__ == '__main__':
    unittest.main()
