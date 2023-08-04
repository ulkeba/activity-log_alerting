targetScope = 'subscription'

param location string = 'westeurope'
param mailAddress string
param adminUsername string 
@secure()
param adminPassword string

param servicePrefix string = 'alertdemo-d01'

resource alertDefsRg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: '${servicePrefix}-def'
  location: location
}

resource alertDemoD01Rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: '${servicePrefix}-rg1'
  location: location
}

resource alertDemoD02Rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: '${servicePrefix}-rg2'
  location: location
}

// Definition of action group and alerts

module actionGroup 'actiongroup.bicep' = {
  name : '${servicePrefix}-actiongroup'
  scope: alertDefsRg
  params: {
    servicePrefix: servicePrefix
    mailAddress: mailAddress
  }
}

module alertDefRg1 'alert.bicep' = {
  name: '${alertDefsRg.name}-alert-rg1'
  scope: alertDefsRg
  params: {
    name: '${alertDefsRg.name}-alert-rg1'
    actionGroupId: actionGroup.outputs.actionGroupId
    description: 'Alert triggered on RG1'
    scopes: [
      alertDemoD01Rg.id
    ]
  }
}

module alertDefRg1Rg2 'alert.bicep' = {
  name: '${alertDefsRg.name}-alert-rg1rg2'
  scope: alertDefsRg
  params: {
    name: '${alertDefsRg.name}-alert-rg1rg2'
    actionGroupId: actionGroup.outputs.actionGroupId
    description: 'Alert triggered on RG1 OR RG2'
    scopes: [
      alertDemoD01Rg.id
      alertDemoD02Rg.id
    ]
  }
}

module alertDefSub 'alert.bicep' = {
  name: '${alertDefsRg.name}-alert-sub'
  scope: alertDefsRg
  params: {
    name: '${alertDefsRg.name}-alert-sub'
    actionGroupId: actionGroup.outputs.actionGroupId
    description: 'Alert triggered somewhere in subscription'
    scopes: [
      subscription().id
    ]
  }
}


// Deployment of demo vm and its resource specific alert.

module vm1 'vm.bicep' = {
  name: '${alertDemoD01Rg.name}-vm1'
  scope: alertDemoD01Rg
  params: {
    vmName: '${alertDemoD01Rg.name}-vm1'
    location: location
    adminUsername: adminUsername
    adminPassword: adminPassword
  }
}


module alertDefVm1 'alert.bicep' = {
  name: '${alertDefsRg.name}-alert-vm1'
  scope: alertDefsRg
  params: {
    name: '${alertDefsRg.name}-alert-vm1'
    actionGroupId: actionGroup.outputs.actionGroupId
    description: 'Alert triggered on VM1'
    scopes: [
      vm1.outputs.vmId
    ]
  }
}
