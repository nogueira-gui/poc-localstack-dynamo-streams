# DynamoDB Streams Simulation using LocalStack

This project simulates the behavior of DynamoDB Streams using LocalStack, a tool that provides a local simulation of various AWS services, including DynamoDB, Lambda, and SQS, which are used in this example.
## Prerequisites

- [Docker](https://www.docker.com/)  installed and running.

## Environment Setup

1. Clone this repository:

   ```bash
   git clone https://github.com/nogueira-gui/poc-localstack-dynamo-streams
   cd poc-localstack-dynamo-streams

2. Execute the Docker Compose to create the LocalStack image:
    ```bash
   docker-compose up

3. Then run the script responsible for executing the commands to create Dynamo, Lambda, and SQS services:
    ```bash
   ./execute_scripts.sh

4. To test the functionality, execute the script that inserts a record into the DynamoDB table:
    ```bash
    ./insert.sh  

5. Check the output in the terminal, which should indicate the result of processing the event published in the SQS queue:
    ```bash
    aws --endpoint-url http://localhost:4566 sqs receive-message --queue-url http://localhost:4566/000000000000/test-queue --region us-east-1

## Project Structure
- lambda_function.py: Contains the simulated Lambda function that processes DynamoDB Streams events and sends the result to an SQS queue.
- src/dynamo_event_handler.py: Contains the logic for processing DynamoDB Streams events.
- src/queue.py: Contains the send function that sends messages to an SQS queue.
- docker-compose.yml: Docker Compose configuration file for LocalStack.
- execute_scripts.sh: Script to execute commands that create the AWS infrastructure in LocalStack.
- scripts/01_create_profile.sh: Creates the account profile.
- scripts/02_create_bucket.sh: Creates an S3 bucket.
- scripts/03_create_queue.sh: Creates an SQS queue.
- scripts/04_create_function.sh: Creates a Lambda function.
- scripts/05_create_dynamodb_table.sh: Creates a DynamoDB table and configures the stream with the Lambda function.
- insert.sh: Inserts a record into the DynamoDB table.

## Contributions
Feel free to contribute to this project by opening issues or sending pull requests. If you have suggestions for improvements or encounter issues, we'd love to hear your feedback!
## License
This project is licensed under the MIT License.