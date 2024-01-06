#!/bin/bash
AWS_ENDPOINT_URL="http://localhost:4566"
BUCKET_NAME="bucket-exam-files"
FUNCTION_NAME="lbd-search-file"
FILE_KEY="data.json"
LOCAL_FILE_PATH="data/data.json"
PROFILE="localstack-profile"
echo "---------------------Criando Bucket S3----------------------------"
aws --endpoint-url=$AWS_ENDPOINT_URL s3api create-bucket --bucket $BUCKET_NAME --profile $PROFILE

echo "------Fazendo upload do arquivo cloud_practioner_1.json-----------"
aws --endpoint-url=$AWS_ENDPOINT_URL s3 cp $LOCAL_FILE_PATH s3://$BUCKET_NAME/$FILE_KEY --profile $PROFILE