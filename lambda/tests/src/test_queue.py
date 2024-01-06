import unittest
from unittest.mock import patch, MagicMock
from src.queue import send


class TestSQSSender(unittest.TestCase):

    @patch('src.queue.boto3.client')
    def test_send_message_success(self, mock_boto_client):
        # Configuração do mock para o cliente SQS
        mock_sqs_client = MagicMock()
        mock_boto_client.return_value = mock_sqs_client

        # Configuração do mock para o envio bem-sucedido
        mock_sqs_client.send_message.return_value = {'MessageId': '123456789'}

        # Chama a função send
        message = 'Test message'
        send(message)

        # Verifica se o método send_message foi chamado com os parâmetros corretos
        mock_sqs_client.send_message.assert_called_once_with(
            QueueUrl='http://localstack:4566/000000000000/test-queue',
            MessageBody=message
        )

    @patch('src.queue.boto3.client')
    def test_send_message_failure(self, mock_boto_client):
        # Configuração do mock para o cliente SQS
        mock_sqs_client = MagicMock()
        mock_boto_client.return_value = mock_sqs_client

        # Configuração do mock para simular uma exceção ao enviar a mensagem
        mock_sqs_client.send_message.side_effect = Exception('Erro simulado')

        # Chama a função send e verifica se ela levanta uma exceção
        with self.assertRaises(Exception):
            message = 'Test message'
            send(message)

        # Verifica se o método send_message foi chamado com os parâmetros corretos
        mock_sqs_client.send_message.assert_called_once_with(
            QueueUrl='http://localstack:4566/000000000000/test-queue',
            MessageBody=message
        )


if __name__ == '__main__':
    unittest.main()
