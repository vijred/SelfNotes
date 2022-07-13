#< This script will export azure run as certificate to storage account>
# prerequistes : create storage account and storage container 
# you need to replace paramaters $storageAccountResourceGroup ,$storageAccount ,$storageContainer = "cert", "YourStrongPasswordForTheCert"
# Tested with powershell version 5.1, not 7.2

$storageAccountResourceGroup = "vj-rg-somename"
$storageAccount ="vjstorage"
$storageContainer = "installcontainer"
# Set the password used for this certificate
$Password = "YourStrongPasswordForTheCert"

$connectionName = "AzureRunAsConnection"
try
{
    # Get the connection "AzureRunAsConnection "
    $servicePrincipalConnection=Get-AutomationConnection -Name $connectionName

    "Logging in to Azure..."
    Add-AzAccount `
        -ServicePrincipal `
        -Tenant $servicePrincipalConnection.TenantId `
        -ApplicationId $servicePrincipalConnection.ApplicationId `
        -CertificateThumbprint $servicePrincipalConnection.CertificateThumbprint 
}
catch {
    if (!$servicePrincipalConnection)
    {
        $ErrorMessage = "Connection $connectionName not found."
        throw $ErrorMessage
    } else{
        Write-Error -Message $_.Exception
        throw $_.Exception
    }
}

#Get all ARM resources from all resource groups
$subscription = Get-Azsubscription
$account = get-azcontext -listavailable | select Account
$subscription
Write-output "$account"

get-azcontext -listavailable | select Account
#get-azvm | start-azvm -nowait



# Stop on errors
$ErrorActionPreference = 'stop'

# Get the management certificate that will be used to make calls into Azure Service Management resources
$RunAsCert = Get-AutomationCertificate -Name "AzureRunAsCertificate"
       
# location to store temporary certificate in the Automation service host
$CertPath = Join-Path $env:temp  "AzureRunAsCertificate.pfx"
   
# Save the certificate
$Cert = $RunAsCert.Export("pfx",$Password)
Set-Content -Value $Cert -Path $CertPath -Force -Encoding Byte | Write-Verbose 

Write-Output ("Importing certificate into local machine root store from " + $CertPath)
$SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force

$storageAccount = Get-AzStorageAccount -ResourceGroupName $storageAccountResourceGroup -Name $storageAccount


$ctx = $storageAccount.Context

set-AzStorageblobcontent -File $CertPath -Container $storageContainer -Blob "AzureRunAsCertificate.pfx"  -Context $ctx
