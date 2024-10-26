@description('The location of the resources.')
param location string = resourceGroup().location

@description('The name of the App Service Plan.')
param appServicePlanName string = 'suncoastcloudappserviceplan'

@description('The name of the Web App.')
param webAppName string = 'suncoastcloudwebapp'

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'F1'
    tier: 'Free'
  }
  tags: {
    environment: 'production'
    project: 'suncoastcloud'
  }
}

resource webApp 'Microsoft.Web/sites@2023-12-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      appSettings: [
        {
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        }
      ]
    }
  }
  tags: {
    environment: 'production'
    project: 'suncoastcloud'
  }
}
