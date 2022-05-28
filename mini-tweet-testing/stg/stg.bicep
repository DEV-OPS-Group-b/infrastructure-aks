param storageAccounts_minitweetstorageclusterstage_name string = 'stgminitweettesting01'
param location string = resourceGroup().location

resource storageAccounts_minitweetstorageclusterstage_name_resource 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: storageAccounts_minitweetstorageclusterstage_name
  location: location
  tags: {
    CostCenter: 'LandingZone'
  }
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    defaultToOAuthAuthentication: false
    allowCrossTenantReplication: true
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: true
    allowSharedKeyAccess: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      requireInfrastructureEncryption: false
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource storageAccounts_minitweetstorageclusterstage_name_default 'Microsoft.Storage/storageAccounts/blobServices@2021-06-01' = {
  parent: storageAccounts_minitweetstorageclusterstage_name_resource
  name: 'default'
  properties: {
    changeFeed: {
      enabled: false
    }
    restorePolicy: {
      enabled: false
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    cors: {
      corsRules: [

      ]
    }
    deleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    isVersioningEnabled: false
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_minitweetstorageclusterstage_name_default 'Microsoft.Storage/storageAccounts/fileServices@2021-06-01' = {
  parent: storageAccounts_minitweetstorageclusterstage_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
    
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
  
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_minitweetstorageclusterstage_name_default 'Microsoft.Storage/storageAccounts/queueServices@2021-06-01' = {
  parent: storageAccounts_minitweetstorageclusterstage_name_resource
  name: 'default'

  properties: {
    cors: {
      corsRules: [
      ]
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_minitweetstorageclusterstage_name_default 'Microsoft.Storage/storageAccounts/tableServices@2021-06-01' = {
  parent: storageAccounts_minitweetstorageclusterstage_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules:[]
    }
    
  }
}

resource storageAccounts_minitweetstorageclusterstage_name_default_kubernetes_dynamic_pvc_d1a3235e_7b74_4317_901e_73d606299d0e 'Microsoft.Storage/storageAccounts/fileServices/shares@2021-06-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_storageAccounts_minitweetstorageclusterstage_name_default
  name: 'kubernetes-dynamic-pvc-d1a3235e-7b74-4317-901e-73d606299d0e'
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 64
    enabledProtocols: 'SMB'
  }
  
}
