#!/usr/bin/env bash

# Update these to match your needs
STACK_NAME=
REGION=
AWS_S3_DEPLOYMENT_BUCKET_NAME=

AWS_S3_DEPLOYMENT="s3://${AWS_S3_DEPLOYMENT_BUCKET_NAME}"
AWS_S3_DEPLOYMENT_STACKS_FOLDER="stacks"
AWS_S3_DEPLOYMENT_STACKS="${AWS_S3_DEPLOYMENT}/${AWS_S3_DEPLOYMENT_STACKS_FOLDER}/${STACK_FILENAME}"

AWS_S3_DEPLOYMENT_STACK_TEMPLATE_URL="https://s3.${REGION}.amazonaws.com/${AWS_S3_DEPLOYMENT_BUCKET_NAME}/${AWS_S3_DEPLOYMENT_STACKS_FOLDER}/${STACK_FILENAME}"

STACK_FILENAME="stack.yaml"

function upload_stack {
    # Copy to the S3 stacks location
    aws s3 cp $STACK_FILENAME $AWS_S3_DEPLOYMENT_STACKS
}

function upload {
    upload_stack
}

function create_stack {
    upload
    aws cloudformation create-stack --capabilities CAPABILITY_IAM \
        --stack-name $STACK_NAME \
        --template-url=$AWS_S3_DEPLOYMENT_STACK_TEMPLATE_URL
}

function delete_stack {
    aws cloudformation delete-stack --stack-name $STACK_NAME
    aws s3 rm $AWS_S3_DEPLOYMENT_STACKS/$STACK_FILENAME
}

function describe_stack {
    aws cloudformation describe-stacks --stack-name $STACK_NAME --query Stacks[0]
}

function update_stack {
    upload
    aws cloudformation update-stack --capabilities CAPABILITY_IAM --stack-name $STACK_NAME --template-url=$AWS_S3_DEPLOYMENT_STACK_TEMPLATE_URL
}

function deploy {
    if (aws cloudformation describe-stacks --stack-name $STACK_NAME &> /dev/null); then
        echo "Stack already exists: updating"
        update_stack
    else
        echo "Stack doesn't exist: creating"
        create_stack
    fi
}

if [[ -z "$STACK_NAME" ]]; then
    echo "'STACK_NAME' must not be empty."
    exit 1
fi

if [ -z "$AWS_S3_DEPLOYMENT_BUCKET_NAME" ]; then
    echo "'AWS_S3_DEPLOYMENT_BUCKET_NAME' must not be empty."
    exit 1
fi

if [ -z "$REGION" ]; then
    echo "'REGION' must not be empty."
    exit 1
fi

if [ "$#" -ne 1 ]; then
    name = $(basename -- "$0")
    echo "Usage: $name [create|delete|deploy|describe|update|upload"
fi

if [ $1 == "create" ]; then
    create_stack
elif [ $1 == "delete" ]; then
    delete_stack
elif [ $1 == "deploy" ]; then
    deploy
elif [ $1 == "describe" ]; then
    describe_stack
elif [ $1 = "update" ]; then
    upload
    update_stack
elif [ $1 == "upload" ]; then
    upload
fi
