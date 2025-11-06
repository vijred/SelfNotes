from azure.identity import DefaultAzureCredential
from azure.keyvault.keys import KeyClient

# Set the URL of your Key Vault
vault_url = "https://mykvname.vault.azure.net/"

# Use DefaultAzureCredential for authentication
credential = DefaultAzureCredential()

# Create a KeyClient instance
client = KeyClient(vault_url=vault_url, credential=credential)

# List keys in the Key Vault
keys = client.list_properties_of_keys()

# Print keys
print("Keys in the Key Vault:")
for key in keys:
    print(key.name)

# Sample to export required credentails on Linux
# export AZURE_CLIENT_ID='asdffasdd-sadfsdaf-44d5-aefc-sfgsdfs'
# export AZURE_CLIENT_SECRET='sdfdf_SDfsdf~asdfasdfdfsdfsfsdf'
# export AZURE_TENANT_ID='sdfsdf-asdfasdf-dfd-dfd-sdsfsdfsdsfd'
