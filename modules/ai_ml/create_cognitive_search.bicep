// SET MODULE DATE
param module_metadata object = {
  module_last_updated : '2023-06-14'
  owner: 'miztiik@github'
}

param deploymentParams object
param uami_name_akane string

param tags object

@description('Get function existing User-Assigned Managed Identity')
resource r_uami_akane 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' existing = {
  name: uami_name_akane
}


var cognitive_search_name = replace('${deploymentParams.enterprise_name_suffix}-${deploymentParams.loc_short_code}-search-${deploymentParams.global_uniqueness}', '_', '-')

resource r_cognitive_search 'Microsoft.Search/searchServices@2021-04-01-preview' = {
  name: cognitive_search_name
  location: deploymentParams.location
  tags: tags
  sku: {
    name: 'basic'
    // name: 'storage_optimized_l2'
  }
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${r_uami_akane.id}': {}
    }
  }
  properties: {
    replicaCount: 1
    partitionCount: 1
    hostingMode: 'default'
    // hostingMode: 'highDensity'
  }
}

// OUTPUTS
output module_metadata object = module_metadata

output name string = r_cognitive_search.name
