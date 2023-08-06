#!/bin/bash
AWS_ENDPOINT_URL="http://localhost:4566"
FUNCTION_NAME="lbd-search-file"

export AWS_ACCESS_KEY_ID=my_access_key
export AWS_SECRET_ACCESS_KEY=my_secret_key

cat > payload.json <<EOF
{
    "file_key": "cloud_practioner_1.json"
}
EOF

echo "Invoking $FUNCTION_NAME"
aws --endpoint-url $AWS_ENDPOINT_URL lambda invoke \
    --function-name $FUNCTION_NAME \
    --payload file://payload.json \
    response.json