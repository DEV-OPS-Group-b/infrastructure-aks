@secure()
param clientId string
param secret string
param managedCluster_name string = 'aks-minitweet-testing-01'
param location string =  resourceGroup().location
@allowed([
  'Paid'
])
param skucost string = 'Paid'

/* 
rg-aks-testing-minitweet-westeurope-01
*/

resource managedClusters_name_resource 'Microsoft.ContainerService/managedClusters@2021-10-01' = {
  name: managedCluster_ _name
  location: location
  sku: {
    name:  'Basic'
    tier:  skucost
  }
  properties: {
    kubernetesVersion: '1.22.6'
    dnsPrefix: '${managedCluster_ _name}-dns'
    agentPoolProfiles: [
      {
        name: 'agentpool'
        count: 2
        vmSize: 'Standard_B2s'
        osDiskSizeGB: 32
        osDiskType: 'Managed'
        kubeletDiskType: 'OS'
        maxPods: 110
        type: 'VirtualMachineScaleSets'
        availabilityZones: [
          '1'
          '2'
          '3'
        ]
        maxCount: 4
        minCount: 2
        
        enableAutoScaling: true
        orchestratorVersion: '1.22.6'
        mode: 'System'
        osType: 'Linux'
        osSKU: 'Ubuntu'
        enableFIPS: false
      }
      {
        name: 'highmem'
        count: 2
        vmSize: 'Standard_B2s'
        osDiskSizeGB: 32
        osDiskType: 'Managed'
        kubeletDiskType: 'OS'
        maxPods: 250
        type: 'VirtualMachineScaleSets'
        availabilityZones: [
          '1'
          '2'
          '3'
        ]
        enableAutoScaling: true
        maxCount: 4
        minCount: 2
        orchestratorVersion: '1.22.6'
        mode: 'User'
        osType: 'Linux'
        osSKU: 'Ubuntu'
        enableFIPS: false
      }
    ]
    servicePrincipalProfile: {
      clientId: clientId
      secret: secret
    }
    addonProfiles: {
      azurepolicy: {
        enabled: false
      }
      httpApplicationRouting: {
        enabled: false
      }
    }
    nodeResourceGroup: 'rg-minitweet-aksresources-testing-01'
    enableRBAC: true
    networkProfile: {
      networkPlugin: 'kubenet'
      loadBalancerSku: 'standard'
      loadBalancerProfile: {
        managedOutboundIPs: {
          count: 1
        }
      }
      podCidr: '10.244.0.0/16'
      serviceCidr: '10.0.0.0/16'
      dnsServiceIP: '10.0.0.10'
      dockerBridgeCidr: '172.17.0.1/16'
      outboundType: 'loadBalancer'
    }
    apiServerAccessProfile: {
      enablePrivateCluster: false
    }
    autoScalerProfile: {
      'balance-similar-node-groups': 'false'
      expander: 'random'
      'max-empty-bulk-delete': '10'
      'max-graceful-termination-sec': '600'
      'max-node-provision-time': '15m'
      'max-total-unready-percentage': '45'
      'new-pod-scale-up-delay': '0s'
      'ok-total-unready-count': '3'
      'scale-down-delay-after-add': '10m'
      'scale-down-delay-after-delete': '10s'
      'scale-down-delay-after-failure': '3m'
      'scale-down-unneeded-time': '10m'
      'scale-down-unready-time': '20m'
      'scale-down-utilization-threshold': '0.5'
      'scan-interval': '10s'
      'skip-nodes-with-local-storage': 'false'
      'skip-nodes-with-system-pods': 'true'
    }
  }
}





resource managedClusters_name_agentpool 'Microsoft.ContainerService/managedClusters/agentPools@2021-10-01' = {
  parent: managedClusters_name_resource
  name: 'agentpool'
  properties: {
    count: 3
    vmSize: 'Standard_B2s'
    osDiskSizeGB: 32
    osDiskType: 'Managed'
    kubeletDiskType: 'OS'
    maxPods: 110
    type: 'VirtualMachineScaleSets'
    availabilityZones: [
      '1'
      '2'
      '3'
    ]
    maxCount: 4
    minCount: 2
    enableAutoScaling: true
    orchestratorVersion: '1.22.6'
    mode: 'System'
    osType: 'Linux'
    osSKU: 'Ubuntu'
    enableFIPS: false
  }
}

resource managedClusters_name_highmem 'Microsoft.ContainerService/managedClusters/agentPools@2021-10-01' = {
  parent: managedClusters_name_resource
  name: 'highmem'
  properties: {
    count: 2
    vmSize: 'Standard_B2s'
    osDiskSizeGB: 32
    osDiskType: 'Managed'
    kubeletDiskType: 'OS'
    maxPods: 250
    type: 'VirtualMachineScaleSets'
    availabilityZones: [
      '1'
      '2'
      '3'
    ]
    maxCount: 4
    minCount: 2w
    enableAutoScaling: true
    orchestratorVersion: '1.22.6'
    mode: 'User'
    osType: 'Linux'
    osSKU: 'Ubuntu'
    enableFIPS: false
  }
}
