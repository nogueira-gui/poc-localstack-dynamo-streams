#!/bin/bash
AWS_ENDPOINT_URL="http://localhost:4566"
FUNCTION_NAME="lbd-search-file"
ZIP_FILE=lambda_function.zip
IAM_ROLE_ARN="arn:aws:iam::000000000000:role/lambda-role"
export PATH=$PATH:"C:\Program Files\7-Zip" #if windows uncomment this lin
echo "-----------------Create lambda_function.zip---------------"
# tar -czvf lambda_function.zip ./lambda #if windows comment this line
7z a -r lambda_function.zip ./lambda/*

echo "-----------------Delete lambda policy---------------"
aws --endpoint-url=$AWS_ENDPOINT_URL iam delete-policy \
    --policy-arn arn:aws:iam::000000000000:policy/lambda-policy \
    --profile localstack-profile

echo "-----------------Create lambda policy---------------"
cat > lambda-policy.json <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject"
                ],
            "Resource": [
                    "*"
            ]
        }
    ]
}
EOF

aws --endpoint-url=$AWS_ENDPOINT_URL iam create-policy \
    --policy-name lambda-policy \
    --policy-document file://lambda-policy.json \
    --profile localstack-profile

echo "-----------------Detach lambda policy---------------"
aws --endpoint-url=$AWS_ENDPOINT_URL iam detach-role-policy \
    --role-name lambda-role \
    --policy-arn arn:aws:iam::000000000000:policy/lambda-policy \
    --profile localstack-profile

echo "-----------------Delete lambda role---------------"
aws --endpoint-url=$AWS_ENDPOINT_URL iam delete-role \
    --role-name lambda-role \
    --profile localstack-profile

echo "-----------------Create lambda role---------------"
cat > trust-policy.json <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "lambda.amazonaws.com"
                },
                "Action": "sts:AssumeRole"
                }
    ]
}
EOF

aws --endpoint-url=$AWS_ENDPOINT_URL iam create-role \
    --role-name lambda-role \
    --assume-role-policy-document file://trust-policy.json \
    --profile localstack-profile


echo "-----------------Attach lambda policy---------------"
aws --endpoint-url=$AWS_ENDPOINT_URL iam attach-role-policy \
    --role-name lambda-role \
    --policy-arn arn:aws:iam::000000000000:policy/lambda-policy \
    --profile localstack-profile

echo "-----------------Delete lambda function---------------" 
aws --endpoint-url=$AWS_ENDPOINT_URL lambda delete-function \
    --function-name $FUNCTION_NAME \
    --profile localstack-profile

echo "-----------------Create lambda function---------------"
aws --endpoint-url $AWS_ENDPOINT_URL lambda create-function \
    --function-name $FUNCTION_NAME \
    --runtime python3.8 \
    --handler lambda_function.lambda_handler \
    --timeout 15 \
    --zip-file fileb://$ZIP_FILE \
    --role $IAM_ROLE_ARN \
    --profile localstack-profile

# Remover o arquivo ZIP após criar a função Lambda (opcional)
rm $ZIP_FILE