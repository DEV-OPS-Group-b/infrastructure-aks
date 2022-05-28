param publicIPAddresses_minitweet_stage_kubernetes_ip_name string = 'pip-minitweet-testing-01'
param location string = resourceGroup().location

resource publicIPAddresses_minitweet_stage_kubernetes_ip_name_resource 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: publicIPAddresses_minitweet_stage_kubernetes_ip_name
  location: location
  tags: {
    CostCenter: 'LandingZone'
  }
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  zones: [
    '1'
    '2'
    '3'
  ]
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
  }
}
