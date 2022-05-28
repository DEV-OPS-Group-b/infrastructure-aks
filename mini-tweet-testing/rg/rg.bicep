@description('Specifies the name of resource.')
param name string = 'rg-minitweet-testing-01'

@description('Specifies the location for resources.')
param location string = 'westeurope'


targetScope = 'subscription'
//create the resource group

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: name
  location: location
}
