// storage container module

param storageAccountName string 
param containerName string = 'web'

resource storageContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  name: '${storageAccountName}/default/${containerName}'
  properties: {
    publicAccess: 'None'
  }
}

output storageContainerName string = storageContainer.name
