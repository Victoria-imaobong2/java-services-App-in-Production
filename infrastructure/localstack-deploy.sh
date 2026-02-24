#!/bin/bash
set -e
export MSYS_NO_PATHCONV=1

export AWS_ACCESS_KEY_ID="test"
export AWS_SECRET_ACCESS_KEY="test"
export AWS_DEFAULT_REGION="us-east-1"

ENDPOINT="http://localhost:4566"

# Create bucket
aws --endpoint-url=$ENDPOINT s3 mb s3://my-local-bucket || true

# Upload template
aws --endpoint-url=$ENDPOINT s3 cp "./cdk.out/localstack.template.json" s3://my-local-bucket/template.json

# Deploy using create-stack (NOT deploy)
aws --endpoint-url=$ENDPOINT cloudformation create-stack \
    --stack-name patient-management \
    --template-url http://localhost:4566/my-local-bucket/template.json \
    --capabilities CAPABILITY_IAM

echo "Stack creation initiated."