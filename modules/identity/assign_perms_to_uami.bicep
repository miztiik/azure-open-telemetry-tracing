// SET MODULE DATE
param module_metadata object = {
  module_last_updated : '2023-06-15'
  owner: 'miztiik@github'
}

param uami_name_akane string

@description('Get function existing User-Assigned Managed Identity')
resource r_uami_akane 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' existing = {
  name: uami_name_akane
}

///////////////////////////////////////////
//                                       //
//   Attach Permissions to the Identity  //
//                                       //
///////////////////////////////////////////

// Add permissions to the Function App identity
// Azure Built-In Roles Ref: https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles

var builtInRoleNames = [
  {
    name: 'Owner'
    id: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '8e3af657-a8ff-443c-a75c-2fe8c4bcb635')
  }
  {
    name: 'Contributor'
    id: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b24988ac-6180-42a0-ab88-20f7382dd24c')
  }
  {
    name: 'Reader'
    id: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'acdd72a7-3385-48ef-bd42-f606fba81ae7')
  }
  {
    name: 'Storage Blob Data Contributor'
    id: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'ba92f5b4-2d11-453d-a403-e96b0029c9fe')
  }
  {
    name: 'Azure Service Bus Data Owner'
    id: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '090c5cfd-751d-490a-894a-3ce6f1109419')
  }
  {
    name: 'Azure Sentinel Automation Contributor'
    id: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'f4c81013-99ee-4d62-a7ee-b3f1f648599a')
  }
  {
    name: 'Log Analytics Contributor'
    id: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '92aaf0da-9dab-42b6-94a3-d43ce8d16293')
  }
  {
    name: 'Data Factory Contributor'
    id: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '673868aa-7521-48a0-acc6-0f60742d39f5')
  }
  {
    name: 'Logic App Contributor'
    id: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '87a39d53-fc1b-424a-814c-f7e04687dc9e')
  }
  {
    name: 'Logic App Operator'
    id: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '515c2055-d9d4-4321-b1b9-bd0c9a0f79fe')
  }
  {
    name: 'Managed Application Contributor Role'
    id: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '641177b8-a67a-45b9-a033-47bc880bb21e')
  }
  {
    name: 'Managed Application Operator Role'
    id: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'c7393b34-138c-406f-901b-d8cf2b17e6ae')
  }
  {
    name: 'Managed Applications Reader'
    id: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b9331d33-8a36-4f8c-b097-4f54124fdb44')
  }
  {
    name: 'Monitoring Contributor'
    id: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '749f88d5-cbae-40b8-bcfc-e573ddc772fa')
  }
  {
    name: 'Monitoring Metrics Publisher'
    id: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')
  }
  {
    name: 'Monitoring Reader'
    id: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '43d0d8ad-25c7-4714-9337-8ba259a9fe05')
  }
  {
    name: 'Resource Policy Contributor'
    id: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '36243c78-bf99-498c-9df9-86d9f8d28608')
  }
  {
    name: 'User Access Administrator'
    id: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '18d7d88d-d35e-4fb5-a5c3-7773c20a72d9')
  }
  {
    name: 'Search Index Data Contributor'
    id: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '8ebe5a00-799e-43f5-93ac-243d3dce84a7')
  }
]

@description('Assign the Permissions to Role')
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = [for role in builtInRoleNames: {
  name: guid(r_uami_akane.id, resourceGroup().id, role.name)
  properties: {
    roleDefinitionId: role.id
    principalId: r_uami_akane.properties.principalId
  }
}]

// Output
output module_metadata object = module_metadata
