﻿# Commands used to build custom image and test it.

# Reference: https://learn.microsoft.com/en-us/azure/virtual-machines/linux/build-image-with-packer
# https://medium.com/slalom-build/azure-packer-592c4dc0e23a
# https://github.com/markti/azure-terraformer/tree/main/episodes/014/infra-machine-images

# Create a resource group 
az group create -n myResourceGroup -l eastus 

# Create a service principal 
az ad sp create-for-rbac --query "{ client_id: appId, client_secret: password, tenant_id: tenant }" 

# Obtain your Azure subscription ID
az account show --query "{ subscription_id: id }"

# Build the image
packer build ubuntu.json

# Create VM from Azure Image
az vm create --resource-group myResourceGroup --name myVM --image myPackerImage --admin-username azureuser --generate-ssh-keys

# Open port 80
az vm open-port --resource-group myResourceGroup --name myVM --port 80
