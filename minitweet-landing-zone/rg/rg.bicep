@description('Specifies the name of resource.')
param name string = '86c5ceb27e1bf441130299c0209e5f35b889'

@description('Specifies the location for resources.')
param location string = 'eastus2'


targetScope = 'subscription'
//create the resource group

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: name
  location: location
}
