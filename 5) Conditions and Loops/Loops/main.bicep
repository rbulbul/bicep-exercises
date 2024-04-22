// deploy back-end infrastructure, including some Azure SQL logical servers
// deploy a dedicated logical server to each country/region
@description('The Azure regions into which the resources should be deployed')
param locations array = [
  'eastus2'
  'eastasia'
]

@description('The administrator login username for the SQL server')
param sqlServerAdministratorLogin string

@secure()
@description('The administrator login password for the SQL server')
param sqlServerAdministratorLoginPassword string

module databases 'modules/database/database.bicep' = [for location in locations: {
  name: 'database-${location}'
  params: {
    location: location
    sqlServerAdministratorLogin: sqlServerAdministratorLogin
    sqlServerAdministratorLoginPassword: sqlServerAdministratorLoginPassword
  }
}]
