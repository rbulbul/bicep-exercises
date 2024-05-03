// This file deploys an Azure App Service plan and an app

@description('The Azure region into which the resources should be deployed')
param location string

@description('The name of the App service app')
param appServiceAppName string

@description('The name of the App Service plan')
param appServicePlanName string

@description('The name of the App Service plan SKU')
param appServicePlanSkuName string

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


@description('The default host nmae of the App SErvice app')
output appServiceAppHostName string = appServiceApp.properties.defaultHostName
