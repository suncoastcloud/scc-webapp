param location string = resourceGroup().location

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: 'suncoastcloudstorage'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: 'suncoastcloudappserviceplan'
  location: location
  sku: {
    name: 'F1'
    tier: 'Free'
  }
}

resource webApp 'Microsoft.Web/sites@2021-02-01' = {
  name: 'suncoastcloudwebapp'
  location: location
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

output storageAccountName string = storageAccount.name
output webAppName string = webApp.name
output webAppUrl string = 'https://${webApp.defaultHostName}'

resource pipeline 'Microsoft.Resources/deployments@2021-04-01' = {
  name: 'pipelineDeployment'
  properties: {
    mode: 'Incremental'
    template: {
      "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
      "contentVersion": "1.0.0.0",
      "resources": [
        {
          "type": "Microsoft.Resources/deployments",
          "apiVersion": "2021-04-01",
          "name": "nestedDeployment",
          "properties": {
            "mode": "Incremental",
            "templateLink": {
              "uri": "[uri(deployment().properties.templateLink.uri, 'nestedTemplate.json')]",
              "contentVersion": "1.0.0.0"
            }
          }
        }
      ]
    }
  }
}
