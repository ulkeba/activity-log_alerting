# Demo to trigger Activity Log Alerts on different levels

## Deployment

- Create a copy of `auth.sh.template` as `auth.sh` and replace placeholders with your values.
- Run `deploy.sh`.

## Test

- After deployment of infrastructure, wait some minutes to make sure the alert is enabled.
- Stop demo VM using the Azure portal.
- See the four notifications will be sent to your inbox:
  - Alert triggered on VM resource scope: `Important notice: Azure Monitor alert alertdemo-d01-def-alert-vm1 was activated`
  - Alert triggered on resource group scope: `Important notice: Azure Monitor alert alertdemo-d01-def-alert-rg1 was activated`
  - Alert triggered on scope of two resource groups: `Important notice: Azure Monitor alert alertdemo-d01-def-alert-rg1rg2 was activated`
  - Alert triggered on subscription scope: `Important notice: Azure Monitor alert alertdemo-d01-def-alert-sub was activated`


# Resources

- [Activity Log Alerts - Get - REST API (Azure Monitor) | Microsoft Learn](https://learn.microsoft.com/en-us/rest/api/monitor/activity-log-alerts/get?tabs=HTTP)

- [az monitor activity-log alert | Microsoft Learn](https://learn.microsoft.com/en-us/cli/azure/monitor/activity-log/alert?view=azure-cli-latest)

- [Create Azure Monitor alert rules - Azure Monitor | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/alerts-create-new-alert-rule?tabs=metric#create-an-activity-log-alert-rule-from-the-activity-log-pane)
