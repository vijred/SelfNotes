<#
Purpose:
    Demonstrate how an administrative service principal can:
    1. Connect to Azure.
    2. Retrieve a shared Self-Hosted Integration Runtime (SHIR).
    3. Grant Azure RBAC permissions to required resources.
    4. Allow another Azure Data Factory to use the shared SHIR.

Notes:
    - All GUIDs, names, and passwords below are placeholders.
    - Replace with actual values before implementation.
#>

# ---------------------------------------------------------------------
# Login using an administrative service principal
# ---------------------------------------------------------------------

$ApplicationId  = "11111111-2222-3333-4444-555555555555"
$Password       = "DummyPasswordForDocumentationOnly"
$TenantId       = "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee"
$SubscriptionId = "99999999-8888-7777-6666-555555555555"

$SecurePassword = ConvertTo-SecureString -AsPlainText $Password -Force
$Credential = New-Object System.Management.Automation.PSCredential `
    ($ApplicationId, $SecurePassword)

Connect-AzAccount `
    -ServicePrincipal `
    -TenantId $TenantId `
    -Credential $Credential

Set-AzContext -SubscriptionId $SubscriptionId

# ---------------------------------------------------------------------
# Shared Self-Hosted Integration Runtime (SHIR)
# ---------------------------------------------------------------------

$ResourceGroupName          = "rg-shared-prod-001"
$SharedDataFactoryName      = "adf-shared-prod-001"
$SharedIntegrationRuntime   = "shir-shared-prod-001"

$SharedIR = Get-AzDataFactoryV2IntegrationRuntime `
    -ResourceGroupName $ResourceGroupName `
    -DataFactoryName $SharedDataFactoryName `
    -Name $SharedIntegrationRuntime `
    -Type SelfHosted

# ---------------------------------------------------------------------
# Grant another Azure Data Factory access to the shared SHIR
# ---------------------------------------------------------------------

$LinkedFactoryManagedIdentity = "abcdef12-3456-7890-abcd-ef1234567890"

New-AzRoleAssignment `
    -ObjectId $LinkedFactoryManagedIdentity `
    -RoleDefinitionName "Contributor" `
    -Scope $SharedIR.Id


# ---------------------------------------------------------------------
# Example RBAC assignment on Azure SQL Server
# ---------------------------------------------------------------------

$ScopeId = "/subscriptions/99999999-8888-7777-6666-555555555555/resourceGroups/rg-data-prod-001/providers/Microsoft.Sql/servers/sqlsrv-prod-001"

$PrincipalId = "12345678-1234-1234-1234-123456789abc"
$RoleName = "Reader"

New-AzRoleAssignment `
    -ObjectId $PrincipalId `
    -RoleDefinitionName $RoleName `
    -Scope $ScopeId
