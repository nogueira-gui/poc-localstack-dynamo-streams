#!/bin/bash

AWS_ENDPOINT_URL=http://localhost:4566

echo "Creating queue SQS..."
aws --endpoint-url=$AWS_ENDPOINT_URL sqs create-queue \
    --queue-name test-queue \
    --region us-east-1
echo "Done!"


# echo "get queue messages..."
# aws --endpoint-url http://localhost:4566 sqs receive-message --queue-url http://localhost:4566/000000000000/test-queue --region us-east-1