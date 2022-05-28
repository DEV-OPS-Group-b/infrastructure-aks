param cosmosDbName string = 'cosmos-minitweet-testing-01'
param location string = resourceGroup().location

resource cosmosAccount 'Microsoft.DocumentDB/databaseAccounts@2021-04-15' = {
  name: cosmosDbName
  kind: 'GlobalDocumentDB'
  location: location
  properties: {
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
    }
    locations: [
      {
        locationName: location
        failoverPriority: 0
        isZoneRedundant: false
      }
    ]
    databaseAccountOfferType: 'Standard'
  }
}
