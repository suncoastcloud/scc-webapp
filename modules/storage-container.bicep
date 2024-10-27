param storageAccountName string 
param containerName string = 'web'

resource storageContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  name: uniqueString(resourceGroup().id, storageAccountName, containerName)
  properties: {
    publicAccess: 'Container'
  }
}
