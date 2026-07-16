#!/bin/bash

##############################################################################
# Purpose:
#   Demonstrate how an administrative service principal can:
#   1. Authenticate to Azure.
#   2. Retrieve information about a shared SHIR.
#   3. Assign Azure RBAC permissions.
#   4. Allow another Azure Data Factory to consume the shared SHIR.
#
# Notes:
#   - All values are placeholders.
#   - Replace with real values before execution.
##############################################################################

# ---------------------------------------------------------------------------
# Login using an administrative service principal
# ---------------------------------------------------------------------------

APP_ID="11111111-2222-3333-4444-555555555555"
PASSWORD="DummyPasswordForDocumentationOnly"
TENANT_ID="aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee"
SUBSCRIPTION_ID="99999999-8888-7777-6666-555555555555"

az login \
  --service-principal \
  --username "$APP_ID" \
  --password "$PASSWORD" \
  --tenant "$TENANT_ID"

az account set \
  --subscription "$SUBSCRIPTION_ID"

# ---------------------------------------------------------------------------
# Shared Self-Hosted Integration Runtime (SHIR)
# ---------------------------------------------------------------------------

RESOURCE_GROUP="rg-shared-prod-001"
ADF_NAME="adf-shared-prod-001"
SHIR_NAME="shir-shared-prod-001"

SHIR_ID=$(az datafactory integration-runtime show \
  --resource-group "$RESOURCE_GROUP" \
  --factory-name "$ADF_NAME" \
  --name "$SHIR_NAME" \
  --query id \
  --output tsv)

echo "SHIR Resource ID:"
echo "$SHIR_ID"


# ---------------------------------------------------------------------------
# Grant another Azure Data Factory access to the shared SHIR
# ---------------------------------------------------------------------------

LINKED_FACTORY_MANAGED_IDENTITY="abcdef12-3456-7890-abcd-ef1234567890"

az role assignment create \
  --assignee-object-id "$LINKED_FACTORY_MANAGED_IDENTITY" \
  --role "Contributor" \
  --scope "$SHIR_ID"
