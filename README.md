# Azure Resource Deployment Samples Using Terraform

This repository contains various sample configurations for deploying Azure resources using Terraform. Each folder represents a different use case, such as deploying a container app to Azure. There is also a special `scripts` folder that contains a `deploy.sh` script. This script automates the process of initializing, planning, and applying the Terraform templates.

## Repository Structure

.
├── container-app
│ ├── main.tf
│ ├── variables.tf
│ └── outputs.tf
├── another-use-case
│ ├── main.tf
│ ├── variables.tf
│ └── outputs.tf
├── scripts
│ └── deploy.sh
└── README.md


- **container-app**: A sample Terraform configuration for deploying a container app to Azure.
- **another-use-case**: Another sample Terraform configuration for a different use case.
- **scripts**: Contains the `deploy.sh` script for automating the deployment process.

## Prerequisites

1. **Terraform**: Make sure you have Terraform installed on your machine. You can download it from [terraform.io](https://www.terraform.io/downloads.html).
2. **Azure CLI**: Ensure you have the Azure CLI installed and are logged in. You can download it from [docs.microsoft.com](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).

## Setting Up

### 1. Create `terraform.tfvars` File

For each use case you want to deploy, you need to create a `terraform.tfvars` file in the respective folder. This file should contain the following variables:

```ini
client_id       = "your-client-id"
client_secret   = "your-client-secret"
subscription_id = "your-subscription-id"
tenant_id       = "your-tenant-id"

2. Running the Deployment Script
Navigate to the scripts folder and execute the deploy.sh script, providing the path to the use case folder as an argument. This script will initialize, plan, and apply the Terraform configuration.

Example

cd scripts
./deploy.sh ../container-app

This will:

Initialize the Terraform configuration in the container-app folder.
Create a plan for the changes required to reach the desired state defined in the Terraform configuration.
Apply the changes without prompting for confirmation.
Important Notes
Make sure the terraform.tfvars file is correctly set up in each use case folder before running the deploy.sh script.
The deploy.sh script assumes that the path provided is relative to the location of the script itself.
Contributing
Feel free to contribute to this repository by adding new use cases or improving existing configurations. Please ensure that each new use case has a corresponding folder with a terraform.tfvars example.

License
This repository is licensed under the MIT License. See the LICENSE file for more details.