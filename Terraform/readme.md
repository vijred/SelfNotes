Terraform 101
=============


Main commands:
-------------
*  init          Prepare your working directory for other commands
*  validate      Check whether the configuration is valid
*  plan          Show changes required by the current configuration
*  apply         Create or update infrastructure
*  destroy       Destroy previously-created infrastructure


All other commands:
-------------------
*  console       Try Terraform expressions at an interactive command prompt
*  fmt           Reformat your configuration in the standard style
*  force-unlock  Release a stuck lock on the current workspace
*  get           Install or upgrade remote Terraform modules
*  graph         Generate a Graphviz graph of the steps in an operation
*  import        Associate existing infrastructure with a Terraform resource
*  login         Obtain and save credentials for a remote host
*  logout        Remove locally-stored credentials for a remote host
*  output        Show output values from your root module
*  providers     Show the providers required for this configuration
*  refresh       Update the state to match remote systems
*  show          Show the current state or a saved plan
*  state         Advanced state management
*  taint         Mark a resource instance as not fully functional
*  untaint       Remove the 'tainted' state from a resource instance
*  version       Show the current Terraform version
*  workspace     Workspace management
*  reference - https://www.terraform.io/docs/cli/commands/state/show.html 

Options
--------
Global options (use these before the subcommand, if any):
  -chdir=DIR    Switch to a different working directory before executing the
                given subcommand.
  -help         Show this help output, or the help for a specified subcommand.
  -version      An alias for the "version" subcommand.


Options
--------
If you are coming back using Terraform on you machine for experimenting after a long time, this is quick guide to come back.

*  Create the main.tf file with required content
```
terraform {
  # backend "azurerm" {
  # }
  required_providers {
    azurerm = { 
        source  = "hashicorp/azurerm"
        version = "= 3.10" # djp "~> 3.21"
    }     
  }
  required_version = ">=0.15.0" # djp ">= 0.13"
}

# locals {
#   private_dns_link = {
#     "EASTUS" = "/subscriptions/safsfdsafds-dsafdsafds-fdsfdsafdsa-fdsf/resourceGroups/dfdsafd/providers/Microsoft.Network/privateDnsZones"
#     "WESTUS" = "/subscriptions/afdsafdsfd-dsfdafdsf-dsfdsdfdsfdsfdsfdf/resourceGroups/safdfds/providers/Microsoft.Network/privateDnsZones"
#   }
# }

provider "azurerm" {
  skip_provider_registration = true
  features {}
  }

data "azurerm_key_vault" "kv" {
  name                = var.keyvaultname
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault_secret" "vks" {
  name         = var.keyvault_secret_name
  key_vault_id = data.azurerm_key_vault.kv.id
}

module "azure_mssql_server" {
 source               = "http://repository.mydomain.com:1111/artifactory/azure_mssqlserver_0.0.0.tar.gz"
 name                 = var.sql_server_name
 db_names             = var.db_names
 resourceGroupName    = var.resource_group_name
 #...
}
```
* create `variables.tf` file with all variables used
```
variable "keyvaultname" {
  type        = string
  description = "Name of keyvault"
}

variable "keyvault_secret_name" {
  type        = string
  description = "keyvault secret name"
}

variable "resource_group_name" {
  type = string
}
```
* Create variable input file like myvariables.tfvars
```
location                                 = "eastus"
resource_group_name                      = "vj-rg-keyvault"
vnet_resource_group_name                 = "sdfdsf"
vnet_name                                = "vnet1000"
```
*  `terraform init` is the first command to execute that creates `.terraform.lock.hcl` and `.terraform` folder with required modules.
*  If you are prompted for a container name, that indicates Terraform is planning to sore the state file in a storage container like Azure blob. Comment out the block like `backend "azurerm" {}`
*  Login into Azure if you are creating Azure resource `az login --scope https://graph.microsoft.com//.default`
*  Select the correct subscription
```
z login --scope https://graph.microsoft.com//.default
az account list --output table
az account set --subscription "vijay-subscription"
```
*  Create a plan - `terraform plan --var-file="./vjtestenv.tfvars"  --out myplan`
*  Apply the plan `terraform apply "myplan" -auto-approve`


How-to:
-------
* How to pass variables example:
  - terraform plan --var-file="./sample1.tf.vars" --out myplan

* How to apply with auto-approve:
  - terraform apply --var-file="./sample1.tf.vars" -auto-approve

* How to apply a generated plan 
  - terraform apply -auto-approve "myplan"

* How to import configuration into statefile that is alreadt defined in Terraform configuraiton (When a configuration is changed in Azure directly, added the same in Terraform code, -refresh-only addres the resource into statefile) - (https://developer.hashicorp.com/terraform/tutorials/state/refresh) 
  - terraform apply -refresh-only

What is tained in Terraform
---------------------------
* When a resource is not created completed as planned, it is listed as tained resource. manually this resource can be corrected in statefile to using tain and untain commands.
  - Ref: https://www.devopsschool.com/blog/terraform-taint-and-untaint-explained-with-example-programs-and-tutorials/ 


Useful references for good understanding
---------------------------------
* Using complex variables:   https://blog.wimwauters.com/devops/2022-03-01_terraformusecases/ 
* Using Loops: https://blog.gruntwork.io/terraform-tips-tricks-loops-if-statements-and-gotchas-f739bbae55f9

How to pass conditional attributes 
---------------------------------
Reference of the component - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server 
```
  dynamic "azuread_administrator" {
    for_each = var.ad_login != null ? [{
      login     = var.ad_login
      object_id = var.ad_object_id
      azuread_authentication_only = var.azuread_authentication_only
    }] : []
    content {
      login_username = azuread_administrator.value.login
      object_id      = azuread_administrator.value.object_id
      azuread_authentication_only = azuread_administrator.value.azuread_authentication_only
    }
  }
```
  
Terraform Misc 
-------------
* How to handle a Locked state file 
  * `terraform force-unlock [options] LOCK_ID` command can be used to unlock
  * Useful reference: https://buildvirtual.net/terraform-error-locking-state/#:~:text=This%20is%20done%20using%20the,really%20want%20to%20force%2Dunlock%3F
  * What if the file is in Azure, you use it only using Automated Pipelines 
    * One of the option is to open the file in portal and use `Break Lease` option.
      * ![AzureBreakLeaseSample](https://user-images.githubusercontent.com/7520740/218124213-0801eda9-3d62-4317-b57b-a0b269db39c3.png)
    * This can also be done using Cmdlets (Ref: https://www.kondaurov.me/2022/unlock-terraform-state-on-azure-storage/) 
