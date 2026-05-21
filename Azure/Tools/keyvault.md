
When we create AMLS or a few AI components, Secrets will be added to key vault with expiration time. That is not hard expiry date, if you just need to update all serets to a new future end date, below is the script!

```
az account set --subscription sdffsd1-sdfdsf-edrfe-wdfe-ssdfsdsdf

for secret in $(az keyvault secret list \
  --vault-name key_vault_name \
  --query "[].id" -o tsv); do
  az keyvault secret set-attributes \
    --id $secret \
    --expires "2046-12-31T00:00:00Z";
done

```
