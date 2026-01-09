Service principles in Azure - 
===================

Service principles can be created in Azure similar to users. Service principle can be configured in Devops and MAchine learning - This is a way to authenticate Devops/ML to access other resources in Azure.

* How to Create an Azure Resource Manager service connection with an existing service principal - 
  * https://learn.microsoft.com/en-us/azure/devops/pipelines/library/connect-to-azure?view=azure-devops#create-an-azure-resource-manager-service-connection-with-an-existing-service-principal
* Validate Service Principal connectiviyt using postname / REST api - https://blog.jongallant.com/2021/02/azure-rest-apis-postman-2021/
* Creating / Deleting SP (Service principal using Azure CLI) - https://learn.microsoft.com/en-us/cli/azure/ad/sp?view=azure-cli-latest#az-ad-sp-list
* Example to cretae SP - `az ad sp create-for-rbac`
*  Example to list the SP created - `az ad sp list  --display-name "azure-cli-2022-10-07-15-11-33"`
*  List all SPs owned by you - `az ad sp list --show-mine`
*  Example to delete a SP, use AppID value as --id parameter - `az ad sp delete --id  "130306da-6f69-49f5-818b-fe4af5c50e16"`
  *  Note - Permissions on Devops projects needs to be explicitly cleand up 
*  

User assigned managed identities
=================
User assigned managed identities enable Azure resources to authenticate to cloud services (e.g. Azure Key Vault) without storing credentials in code. This type of managed identities are created as standalone Azure resources, and have their own lifecycle. A single resource (e.g. Virtual Machine) can utilize multiple user assigned managed identities. Similarly, a single user assigned managed identity can be shared across multiple resources (e.g. Virtual Machine).

Simple script to see the access token - 
```
<#List all things in all subs with api access using azure management api permissions required 
Azure RBAC Roles (Assign at Subscription Level)

    Reader – Allows the application to list resources in a subscription.

API Permissions (Application Type)

    Azure Service Management (user_impersonation) – Required for accessing the management.azure.com API.
#>


# Define App Registration details
$tenantId = "asfsdfsdf-dfce-4f97-asdff-asdfdfsdafsdaf"
$clientId = "asdfdf-4550-afdaf-9c47-sadfdfdfdfasf"
$clientSecret = "asasdfsdafdsafsdfafsdafsd"

# Define the resource for Azure Management API
$resource = "https://management.azure.com/"
$tokenUrl = "https://login.microsoftonline.com/$tenantId/oauth2/token"

# Get authentication token using client credentials flow
$body = @{
    grant_type    = "client_credentials"
    client_id     = $clientId
    client_secret = $clientSecret
    resource      = $resource
}

$response = Invoke-RestMethod -Method Post -Uri $tokenUrl -ContentType "application/x-www-form-urlencoded" -Body $body
$accessToken = $response.access_token

# Validate token retrieval
if (-not $accessToken) {
    Write-Host "Failed to obtain access token" -ForegroundColor Red
    exit
}

# Write-Host $accessToken

Write-Host "Access Token obtained successfully" -ForegroundColor Green


# Split the token into its parts
$tokenParts = $accessToken -split "\."

# Extract the payload part (Base64 encoded)
$tokenPayload = $tokenParts[1] 

# Decode the Base64 payload
$decodedPayload = [System.Text.Encoding]::UTF8.GetString(
    [Convert]::FromBase64String($tokenPayload + ('=' * ((4 - $tokenPayload.Length % 4) % 4)))
)

# Convert the decoded payload to JSON and format it as a list
$decodedPayload | ConvertFrom-Json | Format-List

```
