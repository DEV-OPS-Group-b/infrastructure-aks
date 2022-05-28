param virtualNetworks_minitweet_testing_network_name string = 'vnet-minitweet-testing-01'
param location string =  resourceGroup().location

resource virtualNetworks_minitweet_testing_network_name_resource 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: virtualNetworks_minitweet_testing_network_name
  location:  location
  tags: {
    CostCenter: 'LandingZone'
  }
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'aks-subnet'
        properties: {
          addressPrefix: '10.1.32.0/19'
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource virtualNetworks_minitweet_testing_network_name_aks_subnet 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: virtualNetworks_minitweet_testing_network_name_resource
  name: 'aks-subnet'
  properties: {
    addressPrefix: '10.1.32.0/19'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}
