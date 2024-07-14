#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <terraform folder>"
  exit 1
fi

TF_DIR=$1

# Initialize Terraform
terraform -chdir=$TF_DIR init

# Create an execution plan
terraform -chdir=$TF_DIR plan -out=tfplan

# Apply the changes without prompting for confirmation
terraform -chdir=$TF_DIR apply -auto-approve