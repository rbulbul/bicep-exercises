// resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
//   name: 'toylaunchstorage'
//   location: 'westus3'
//   sku: {
//     name: 'Standard_LRS'
//   }
//   kind: 'StorageV2'
//   properties: {
//     accessTier: 'Hot'
//   }
// }

// resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
//   name: 'toy-product-launch-plan'
//   location: 'westus3'
//   sku: {
//     name: 'F1'
//   }
// }

// resource appServiceApp 'Microsoft.Web/sites@2023-01-01' = {
//   name: 'toy-product-launch-1'
//   location: 'westus3'
//   properties: {
//     serverFarmId: appServicePlan.id
//     httpsOnly: true
//   }
// }

// resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
//   name: 'toylaunchstorageamztest'
//   location: 'westus3'
//   sku: {
//     name: 'Standard_LRS'
//   }
//   kind: 'StorageV2'
//   properties: {
//     accessTier: 'Hot'
//   }
// }


// resource appServiceApp 'Microsoft.Web/sites@2023-01-01' = {
//   name: 'toy-product-launch-amztest'
//   location: 'westus3'
//   properties: {
//     serverFarmId: appServicePlan.id
//     httpsOnly: true
//   }
// }

param location string = resourceGroup().location
param storageAccountName string = 'toylaunc${uniqueString(resourceGroup().id)}'
param appServiceAppName string = 'toylauch${uniqueString(resourceGroup().id)}'
@allowed([
  'nonprod'
  'prod'
])
param environmentType string
var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS':'Standard_LRS'
var appServicePlanSkuName = (environmentType == 'prod') ? 'P2v3' : 'F1'

var appServicePlanName = 'toy-product-launch-plan-starter-amz'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSkuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
  }
}

resource appServiceApp 'Microsoft.Web/sites@2023-01-01' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}
