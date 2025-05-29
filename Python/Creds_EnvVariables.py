# Credentails and Environment variables in Python
# This sample can be used in Databricks as well - 
# Note, .env file needs to be on one of the folders or parent folders. If you execure the code from parent/folder1/p2/p3/subfolder/filename.py, .env file needs to be in subfolder or p3, .. parent folder!

import os
from azure.keyvault.secrets import SecretClient
from azure.identity import DefaultAzureCredential

# load_dotenv loads closed xyz.env file values into OS environment, these can be access using os.environment["envkeyname"]
from dotenv import load_dotenv, find_dotenv
_ = load_dotenv(find_dotenv())

# Example of Keyvault URL 
keyvault_url = os.environ["keyvault_url"]

# A way to load credentials from Env file
credential_default = DefaultAzureCredential()
# ## Sample .env file that will be used in this example 
# keyvault_url="https://kv-mykeyvaultname.vault.azure.net/"
# AZURE_CLIENT_ID = "234234234-24332-2423-edrfs-sadfjrfi3uj3489u3dfeddf"
# AZURE_CLIENT_SECRET = "DJUERIWEE~sdfd.sljfkjfed_SDfsdf.edfwsfasfsadf"
# AZURE_TENANT_ID = "lkfzdjw408aru4j-sljkf02493ur-sdlkfed-1394ifkj-29uifslksd;l"

# Sample way to configure key vault 
s_client = SecretClient(keyvault_url, credential=credential_default)

# Sample to read a key from keyvault 
val=s_client.get_secret("SQLUserN1").value

print(val)


