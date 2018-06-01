# Stacker

A template project to be used as a foundation for managing your AWS CloudFormation stacks
from the command line.

## Getting Started
 
### Prerequisites

* AWS CLI installed and configured

### Installing 

Clone this repository and update the ```stacker.sh```script. See instructions in the script.

### Creating your own stack

The script assumes your CloudFormation stack template to be found in the ```stack.yaml``` file.
When creating the stack this template is first uploaded to S3 before the stack is created.

Before using the ``stacker.sh`` script you have to modify the script as follows:
* set the `STACK_NAME` variable to the name of your stack
* set the `AWS_S3_DEPLOYMENT_BUCKET_NAME` variable to the name of the bucket where `stacker.sh` 
can upload the stack template 

Now update the `stack.yaml` file and add your AWS CloudFormation resources etc. 

### Running `stacker.sh`

The script expects a command as the first parameter. These commands are:

| Name | Description |
|---|---|
|create|Uploads the `stack.yaml` file and creates the stack.|
|update|Updates the stack in AWS.|
|delete|Deletes the stack in AWS. Also removes the `stack.yaml` file from S3|
|deploy|Creates or updates the stack depending on whether a stack with the same name already exists.|
|upload|Uploads the stack template to S3.|
|describe|Prints information about the stack.|

### Examples

Examples can be found in the `examples` directory. To perform the corresponding stack operations
you can do the following:

#### Deploy the stack

```
> ./stacker.sh deploy
```

This creates the stack if it doesn't exist. Otherwise updates the stack.

#### Delete the stack

```
> ./stacker.sh create
```

This deletes the stack.
