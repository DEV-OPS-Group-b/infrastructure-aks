param registries_minitweetdevmanagementregistry_name string = 'acrminitweettesting02'
param location string = resourceGroup().location

resource registries_minitweetdevmanagementregistry_name_resource 'Microsoft.ContainerRegistry/registries@2021-09-01' = {
  name: registries_minitweetdevmanagementregistry_name
  location: location
  tags: {
    CostCenter: 'LandingZone'
  }
  sku: {
    name: 'Premium'
  }
  properties: {
    adminUserEnabled: true
    networkRuleSet: {
      defaultAction: 'Allow'
      ipRules: []
    }
    policies: {
      quarantinePolicy: {
        status: 'disabled'
      }
      trustPolicy: {
        type: 'Notary'
        status: 'disabled'
      }
      retentionPolicy: {
        days: 7
        status: 'disabled'
      }
      exportPolicy: {
        status: 'enabled'
      }
    }
    encryption: {
      status: 'disabled'
    }
    dataEndpointEnabled: false
    publicNetworkAccess: 'Enabled'
    networkRuleBypassOptions: 'AzureServices'
    zoneRedundancy: 'Disabled'
  }
}

resource registries_minitweetdevmanagementregistry_name_repositories_admin 'Microsoft.ContainerRegistry/registries/scopeMaps@2021-12-01-preview' = {
  parent: registries_minitweetdevmanagementregistry_name_resource
  name: '_repositories_admin'
  properties: {
    description: 'Can perform all read, write and delete operations on the registry'
    actions: [
      'repositories/*/metadata/read'
      'repositories/*/metadata/write'
      'repositories/*/content/read'
      'repositories/*/content/write'
      'repositories/*/content/delete'
    ]
  }
}

resource registries_minitweetdevmanagementregistry_name_repositories_pull 'Microsoft.ContainerRegistry/registries/scopeMaps@2021-12-01-preview' = {
  parent: registries_minitweetdevmanagementregistry_name_resource
  name: '_repositories_pull'
  properties: {
    description: 'Can pull any repository of the registry'
    actions: [
      'repositories/*/content/read'
    ]
  }
}

resource registries_minitweetdevmanagementregistry_name_repositories_push 'Microsoft.ContainerRegistry/registries/scopeMaps@2021-12-01-preview' = {
  parent: registries_minitweetdevmanagementregistry_name_resource
  name: '_repositories_push'
  properties: {
    description: 'Can push to any repository of the registry'
    actions: [
      'repositories/*/content/read'
      'repositories/*/content/write'
    ]
  }
}
