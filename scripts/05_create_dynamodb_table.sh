#!/bin/bash

AWS_ENDPOINT_URL=http://localhost:4566
FUNCTION_NAME=lbd-search-file

echo '------------delete a dynamodb table------------'
aws --endpoint-url $AWS_ENDPOINT_URL dynamodb delete-table \
    --table-name test-table \
    --region us-east-1

echo '------------create a dynamodb table------------'
aws --endpoint-url $AWS_ENDPOINT_URL dynamodb create-table \
    --table-name test-table \
    --key-schema AttributeName=id,KeyType=HASH \
    --attribute-definitions AttributeName=id,AttributeType=S \
    --billing-mode PAY_PER_REQUEST \
    --stream-specification StreamViewType=NEW_AND_OLD_IMAGES,StreamEnabled=true \
    --region us-east-1

echo '------------get dynamo stream arn------------'
STREAM_ARN=$(aws --endpoint-url $AWS_ENDPOINT_URL dynamodb describe-table \
    --table-name test-table \
    --region us-east-1 \
    --query 'Table.LatestStreamArn' \
    --output text)
echo $STREAM_ARN

echo "------------create event source mapping for dynamodb streams------------"
aws --endpoint-url=$AWS_ENDPOINT_URL lambda create-event-source-mapping \
    --function-name $FUNCTION_NAME \
    --batch-size 1 \
    --event-source-arn $STREAM_ARN \
    --profile localstack-profile
    


