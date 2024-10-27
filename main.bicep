targetScope = 'subscription'

param location string = 'westus2'

@description('String to make resource names unique')
var resourceToken = uniqueString(subscription().subscriptionId, location)

@description('Create a resource group')
resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: 'rg-swa-app-${resourceToken}'
  location: location
}

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

@description('Output the default hostname')
output endpoint string = staticWebAppModule.outputs.defaultHostname

@description('Output the static web app name')
output staticWebAppName string = staticWebAppModule.outputs.name
