#!/bin/bash

AWS_ENDPOINT_URL=http://localhost:4566
FUNCTION_NAME=lbd-search-file
aws --endpoint-url $AWS_ENDPOINT_URL dynamodb put-item \
    --table-name test-table \
    --item "{\"id\":{\"S\":\"1\"},\"name\":{\"S\":\"Gui\"}}" \
    --region us-east-1