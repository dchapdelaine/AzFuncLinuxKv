#!/bin/bash

RANDOM_SUFFIX=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 5 | head -n 1)
echo "Using random suffix $RANDOM_SUFFIX"
RESOURCE_GROUP=fnkv$RANDOM_SUFFIX-rg
FUNCTION_APP=fnkv$RANDOM_SUFFIX-func
APP_PLAN=fnkv$RANDOM_SUFFIX-plan
KEYVAULT=fnkv$RANDOM_SUFFIX-kv

az login

az group create --name $RESOURCE_GROUP --location eastus
az appservice plan create --name $APP_PLAN --resource-group $RESOURCE_GROUP --sku B1
az webapp create --name $FUNCTION_APP --resource-group $RESOURCE_GROUP --plan $APP_PLAN

az keyvault create -n $KEYVAULT -g $RESOURCE_GROUP -l eastus
az keyvault secret set --vault-name $KEYVAULT -n Secret --value 'MyFancySecret'
SECRET_URI=$(az keyvault secret set --vault-name dotnetkv -n Test --value 'Test' --query id -o json | xargs)


KV_REFERENCE=$(@Microsoft.KeyVault(SecretUri=$SECRET_URI))
az webapp config appsettings set --name dchdotnetkvlinux --resource-group dotnetkv --settings Secret=$KV_REFERENCE

func azure functionapp publish $FUNCTION_APP --nozip