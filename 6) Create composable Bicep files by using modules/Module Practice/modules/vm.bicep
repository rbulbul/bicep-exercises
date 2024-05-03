@description('Username for the virtual machine')
param adminUsername string

@description('Password for the virtual machine')
@minLength(12)
@secure()
param adminPassword string

@description('The resource Id of the subnet where the virtual machine will be deployed')
param subnetResourceId string

@description('Virtual machine Resource')
resource virtualMachine 'Microsoft.Compute/virtualMachines@2023-09-01' = {
  name: 'myVirtualMachine'
  location: resourceGroup().location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DS1_v2'
    }
    osProfile: {
      computerName: 'myVM'
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-datacenter'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: subnetResourceId
        }
      ]
    }
  }
}
