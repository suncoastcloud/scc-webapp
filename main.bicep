targetScope = 'subscription'

var location = 'westus2'

@description('String to make resource names unique')
var resourceToken = uniqueString(subscription().subscriptionId, location)

@description('Create a resource group')
resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: 'rg-${resourceToken}'
  location: location
}

@description('Create a static web app')
module swa 'br/public:avm/res/web/static-site:0.3.0' = {
  name: 'scc-swa'
  scope: rg
  params: {
    name: 'swa-${resourceToken}'
    location: location
    sku: 'Free'
    repositoryUrl: 'https://github.com/suncoastcloud/scc-webapp'
    branch: 'main'
    buildProperties: {
      appLocation: 'sitefiles'  
      apiLocation: ''          
      outputLocation: 'dist'    
    }
  }
}

@description('Output the default hostname')
output endpoint string = swa.outputs.defaultHostname
