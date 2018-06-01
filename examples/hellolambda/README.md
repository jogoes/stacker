# Hello Lambda

Based on the stacker template creates a simple AWS Lambda.

## Getting Started
 
### Installing 

Update 
* `AWS_S3_DEPLOYMENT_BUCKET_NAME` to match the name of a bucket that can be used 
* `REGION` the region the stack should be deployed in (e.g. eu-central-1) 

### Deploying the Stack

To deploy the stack run:
```
> ./stacker.sh deploy

```

To call the AWS Lambda run:
```
> ./call_lambda.sh MyName

```

