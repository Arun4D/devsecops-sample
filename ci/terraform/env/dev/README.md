# terraform-training

## Terraform Resource Group

This project creates an Azure Resource Group using Terraform.

### Prerequisites

- Terraform installed on your machine.
- An Azure account with the necessary permissions to create resources.

````
az login --use-device-code
az account set --subscription <id>
$ENV:ARM_SUBSCRIPTION_ID = ""
export ARM_SUBSCRIPTION_ID = "" 
````

### Getting Started

1. **Clone the repository** (if applicable):
   ```
   git clone <repository-url>
   cd basic
   ```

2. **Initialize Terraform**:
   Run the following command to initialize the Terraform configuration:
   ```
   terraform init 
   ```
3. **Validate Terraform**:
   Run the following command to validate the Terraform configuration:
   ```
   terraform validate
   terraform validate -json
   ```

4. **Plan the deployment**:
   To see what resources will be created, run:
   ```
   terraform plan -out main.tfplan -var-file="../../config/global.tfvars" -var-file="../../config/dev.tfvars"
   terraform show -json main.tfplan
   ```

5. **Apply the configuration**:
   To create the resource group, execute:
   ```
   terraform apply main.tfplan
   ```

   Confirm the action when prompted.

### Variables

The following variables can be configured in `variables.tf`:

- `resource_group_name`: The name of the resource group.
- `location`: The Azure region where the resource group will be created.

### Outputs

After the resource group is created, the following outputs will be available:

- `resource_group_id`: The ID of the created resource group.
- `resource_group_name`: The name of the created resource group.

### Cleanup

To remove the resource group and all associated resources, run:
```
terraform plan -destroy -out destroy-main.tfplan -var-file="../../config/global.tfvars" -var-file="../../config/dev.tfvars"
terraform show -json destroy-main.tfplan
terraform apply destroy-main.tfplan
```