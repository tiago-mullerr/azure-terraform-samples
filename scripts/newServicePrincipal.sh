# Running this will create a new service principal to be used by terraform to create resources in your subscription
# Be sure to save the values for clientId and clientSecret this command will output and save them to the terraform.tfvars file
# in each folder you would like to run the template
az ad sp create-for-rbac --name "YOUR_SVC_PRINCIPAL_NAME_HERE" --role="Contributor" --scopes="/subscriptions/YOUR_SUBSCRIPTION_NAME_HERE"