#!/bin/bash

# Defina as configurações do LocalStack
AWS_ACCESS_KEY_ID="my_access_key"
AWS_SECRET_ACCESS_KEY="my_secret_key"
AWS_REGION="us-east-1"

# Crie o perfil localstack-profile
aws configure --profile localstack-profile set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure --profile localstack-profile set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
aws configure --profile localstack-profile set region $AWS_REGION

# Verifique as configurações do perfil localstack-profile
aws configure list --profile localstack-profile
