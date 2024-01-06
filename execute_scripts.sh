#!/bin/bash
AWS_ENDPOINT_URL="http://localhost:4566"
FUNCTION_NAME="lbd-search-file"
ZIP_FILE=lambda_function.zip
IAM_ROLE_ARN="arn:aws:iam::000000000000:role/lambda-role"

# create_profile
echo "Executando create_profile.sh"
bash ./scripts/create_profile.sh

# create_bucket
echo "Executando create_bucket.sh"
bash ./scripts/create_bucket.sh

echo "Executando create_queue.sh"
bash ./scripts/create_queue.sh

# Navigate to the lambda directory
cd lambda

# Activate the virtual environment (venv)
source venv/Scripts/activate

# Install dependencies from requirements.txt
pip install -r requirements.txt

# Go back to the previous directory
cd ..

# create_function
echo "Executando create_function.sh"
bash ./scripts/create_function.sh

# create_dynamodb_table
echo "Executando create_dynamodb_table.sh"
bash ./scripts/create_dynamodb_table.sh

echo "execute_scripts.sh finalizado!"