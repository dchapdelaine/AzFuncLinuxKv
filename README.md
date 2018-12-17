# AzFuncLinuxKv

Sample project showing how a linux HTTP triggered function can leverage secrets in Azure KeyVault.

## Prerequesites
- .NET Core 2.2 : https://dotnet.microsoft.com/download/dotnet-core/2.2
- Azure Function Runtime Tools: https://docs.microsoft.com/en-us/azure/azure-functions/functions-run-local#v2

## How to use
Inspect Deploy.sh, this script will generate all the required environment including writing a dumb secret to Azure KeyVault which will be fetched at runtime.
