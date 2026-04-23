Azure container Instances 
==================


* Example of starting a container using AZ CLI
```
CONTAINER_NAME="vj-somename-$(date +%s)"

az container create \
--resource-group myResourceGorup \
--name $CONTAINER_NAME \
--image myContainerRegistry.azurecr.io/myImanage-name:latest \
--cpu 4 \
--memory 8 \
--registry-login-server myContainerRegistry.azurecr.io \
--registry-username afdsdsafdafdf \
--registry-password afddafdfd \
--assign-identity "/subscriptions/afdsafd/resourceGroups/afdsaf/providers/Microsoft.ManagedIdentity/userAssignedIdentities/UserAssignedManagedIdentifyName" \
--vnet "/subscriptions/afdsafds/resourceGroups/rg-safdsf/providers/Microsoft.Network/virtualNetworks/vnet-dfdfdafdsaf" \
--subnet "sn-asfdsafdsfds" \
--os-type Linux \
--restart-policy Never \
--command-line "sleep 6000" 

```


* How to login to a container instance once this is up and running -
```
# Exec into the running container
az container exec \
  --resource-group myResourceGroup \
  --name MyContainerName \
  --exec-command "/bin/bash"  
```
