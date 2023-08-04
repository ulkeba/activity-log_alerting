// resource "azurerm_monitor_activity_log_alert" "conmon_asa_stopped" {
//   name                = format("[%s][%s][%s] CONMON ASA job stopped - Critical", upper(var.environment), upper(var.deployment_stamp_name), upper(var.slot_name))
//   resource_group_name = var.resource_group_name
//   scopes              = [local.asaconmonscope]
//   description         = "[CONMON] ASA job has stopped because of failure - Critical"
//   enabled             = var.alerts_enabled
//   tags                = var.azure_resource_tags_per_service_per_slot

param name string
param scopes array
param description string
param actionGroupId string

resource alert 'Microsoft.Insights/activityLogAlerts@2020-10-01' = {
  name: name
  location: 'global'
  properties: {
    scopes: scopes
    description: description
    enabled: true
    condition: {
      allOf: [
        {
          field: 'category'
          equals: 'Administrative'
        }
        {
          field: 'operationName'
          equals: 'Microsoft.Compute/virtualMachines/deallocate/action'
        }
        {
          field: 'status'
          equals: 'Succeeded'
        }
      ]
    }
    actions: {
      actionGroups: [
        {
          actionGroupId: actionGroupId
        }
      ]
    }
  }
}
