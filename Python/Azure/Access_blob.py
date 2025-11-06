import os
from azure.identity import ClientSecretCredential
from azure.storage.blob import BlobServiceClient
from azure.identity import DefaultAzureCredential

# # Retrieve credentials from environment variables / This is one of the ways to authenticate 
# tenant_id = os.getenv("AZURE_TENANT_ID")
# client_id = os.getenv("AZURE_CLIENT_ID")
# client_secret = os.getenv("AZURE_CLIENT_SECRET")
# credential = ClientSecretCredential(tenant_id, client_id, client_secret)


# # Initialize a ClientSecretCredential instance
# # To use this, need to update env variables
# export AZURE_CLIENT_ID='sdfdsfsdsdf'
# export AZURE_CLIENT_SECRET='sdfsdafsdafsd'
# export AZURE_TENANT_ID='sffsdafsfsd'
credential = DefaultAzureCredential()

# Your Blob Storage endpoint
storage_account_url = "https://mydatalakename.blob.core.windows.net/"
container_name = "mycontainername"
blob_name = "mypath1/subfolder/filename.txt"


# Initialize the BlobServiceClient with the credential
blob_service_client = BlobServiceClient(account_url=storage_account_url, credential=credential)

# Specify container and blob to access

try:
    # Get the container client
    container_client = blob_service_client.get_container_client(container_name)

    # Get the blob client
    blob_client = container_client.get_blob_client(blob_name)

    # Download the blob content
    downloaded_blob = blob_client.download_blob()

    # Print the blob content
    content = downloaded_blob.readall()
    print("Blob Content:")
    print(content)

except Exception as e:
    print(f"Failed to access blob: {e}")
