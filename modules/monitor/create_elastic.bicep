// SET MODULE DATE
param module_metadata object = {
  module_last_updated : '2023-06-19'
  owner: 'miztiik@github'
}

param deploymentParams object
param elastic_search_params object
param tags object

var es_cluster_name = replace('${deploymentParams.enterprise_name_suffix}-${deploymentParams.loc_short_code}-${elastic_search_params.name_prefix}-es-${deploymentParams.global_uniqueness}', '_', '-')


resource r_es 'Microsoft.Elastic/monitors@2023-02-01-preview' = {
  name: es_cluster_name
  location: deploymentParams.location
  tags: tags
  sku: {
    name: 'ess-monthly-consumption_Monthly'
  }
  properties: {
    elasticProperties: {
      elasticCloudDeployment: {}
      elasticCloudUser: {}
    }
    monitoringStatus: 'Enabled'
    userInfo: {
      companyInfo: {
        business: ''
        country: 'Zootopia'
        domain: ''
        employeesNumber: '1'
        state: 'Rex Land'
      }
      companyName: 'Miztiik Corp'
      emailAddress: 'miztiik@github.com'
      firstName: 'Miztiik'
      lastName: 'Corp'
    }
    version: ''
  }
}


// OUTPUTS
output module_metadata object = module_metadata
