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

# create_function
echo "Executando create_function.sh"
bash ./scripts/create_function.sh

# invoke_function
echo "Executando invoke_function.sh"
bash ./scripts/invoke_function.sh
