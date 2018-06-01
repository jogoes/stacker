#!/usr/bin/env bash

NAME=${1:-no name}

aws lambda invoke --invocation-type RequestResponse --function-name HelloLambdaFunction --payload "{ \"name\" : \"$NAME\" }" output.txt

OUTPUT=`cat output.txt`
echo "Lambda Result: $OUTPUT"
