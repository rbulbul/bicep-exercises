param location string = resourceGroup().location

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: 'myVirtualNetwork'
  location: location
  properties:{
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'mySubnet'
        properties: {
          addressPrefix: '10.0.0./24'
        }
      }
    ]
  }
}

@description('The resource ID of the subnet created in the virtual network.')
output subnetResourceId string = virtualNetwork.properties.subnets[0].id
