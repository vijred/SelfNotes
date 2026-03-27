Azure Container Apps - ACA 
=========


* How to login into a container app 
There is no SSH option similar to App Service but you can establish a connection from AZ Commands, example I want to login to Container App and verify if a specific package is installed - 
```
# Swith to correct subscription
az account set --subscription fsdfdsfdf-34lk3-3jk2-sfdsf-sdfds7fsd7fsd

az containerapp exec \
  --name ContainerAppName \
  --resource-group rg-ContainerApp-resourcegroup-region-001 \
  --command "/bin/bash"

  pip list | grep -E "testlitellm|testlangchain-litellm"

```
