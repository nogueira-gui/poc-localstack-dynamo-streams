# DynamoDB Streams Simulation using LocalStack

Este projeto simula o comportamento de DynamoDB Streams usando o LocalStack, uma ferramenta que fornece uma simulação local de vários serviços da AWS, incluindo DynamoDB, Lambda e SQS que são usados neste exemplo.

## Pré-requisitos

- [Docker](https://www.docker.com/) instalado e em execução.

## Configuração do Ambiente

1. Clone este repositório:

   ```bash
   git clone https://github.com/nogueira-gui/poc-localstack-dynamo-streams
   cd poc-localstack-dynamo-streams

2. Execute o docker-compose criar imagem do localstack:
    ```bash
   docker-compose up

3. Em seguida execute o arquivo abaixo responsável por executar os comandos de criação dos serviços Dynamo, Lambda e SQS:
    ```bash
   ./execute_scripts.sh

4. Para testar o funcionamento execute o arquivo que insere um registro na tabela do dynamoDb
    ```bash
    ./insert.sh  

5. Verifique a saída no terminal, que deve indicar o resultado do processamento do evento publicado na fila SQS.
    ```bash
    aws --endpoint-url http://localhost:4566 sqs receive-message --queue-url http://localhost:4566/000000000000/test-queue --region us-east-1

## Estrutura do Projeto
- lambda_function.py: Contém a função Lambda simulada que processa eventos do DynamoDB Streams e envia o resultado para uma fila.
- src/dynamo_event_handler.py: Contém a lógica de processamento dos eventos do DynamoDB Streams.
- src/queue.py: Contém a função send que envia mensagens para uma fila SQS.
- docker-compose.yml: Arquivo de configuração do Docker Compose para o LocalStack.
- execute_scripts.sh: Script para executar comandos que criam a infraestrutura AWS no LocalStack.
- 01_create_profile.sh: Cria o perfil da conta.
- 02_create_bucket.sh: Cria bucket S3
- 03_create_queue.sh: Cria Fila SQS
- 04_create_function.sh: Cria Função Lambda
- 05_create_dynamodb_table.sh: Cria tabela do dynamoDB e Configura o stream com a função Lambda
- insert.sh: Insere um registro na tabela do dynamoDB

## Contribuições
Sinta-se à vontade para contribuir para este projeto abrindo issues ou enviando pull requests. Se você tiver sugestões de melhorias ou encontrar problemas, ficaremos felizes em ouvir suas opiniões!

## Licença
Este projeto é licenciado sob a Licença MIT.