// main bicep file for scc webapp

targetScope = 'subscription'

@description('Location for all resources.')
param location string = 'westus2'

@description('String to make resource names unique')
var resourceToken = uniqueString(subscription().subscriptionId, location)

@description('Create a resource group')
resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: 'rg-swa-${resourceToken}'
  location: location
}

@description('Create a storage account')
module storageAccountModule 'br/public:avm/res/storage/storage-account:0.14.3' = {
  name: 'storageAccountModule-${resourceToken}'
  scope: rg
  params: {
    name: 'storage${resourceToken}'
    location: location
    skuName: 'Standard_LRS'
    kind: 'BlobStorage'
    accessTier: 'Hot'
    }
  }

 module storageContainerModule './modules/storage-container.bicep' = { 
    name: 'storageContainerModule-${resourceToken}' 
    scope: rg 
    params: { 
      containerName: 'web'
      storageAccountName: storageAccountModule.outputs.name
    }
 }

// https://learn.microsoft.com/en-us/azure/devops/pipelines/overview-azure?view=azure-devops

@description('Create a static web app')
module staticWebAppModule 'br/public:avm/res/web/static-site:0.3.0' = {
  name: 'staticWebAppModule-${resourceToken}'
  scope: rg
  params: {
    name: 'staticWebApp-${resourceToken}'
    location: location
    sku: 'Free'
  }
}

@description('Output the resource group name')
output resourceGroupName string = rg.name

@description('Output the storage account name')
output storageAccountName string = storageAccountModule.outputs.name

@description('Output the storage container name')
output storageContainerName string = storageContainerModule.outputs.storageContainerName

@description('Output the default hostname')
output endpoint string = staticWebAppModule.outputs.defaultHostname

@description('Output the static web app name')
output staticWebAppName string = staticWebAppModule.outputs.name
