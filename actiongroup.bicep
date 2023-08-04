param mailAddress string
param servicePrefix string

resource actionGroup 'Microsoft.Insights/actionGroups@2023-01-01' = {
  name: '${servicePrefix}-actionGroup1'
  location: 'global'
  properties: {
    groupShortName: substring('${servicePrefix}-actionGroup1', 0, 12)
    enabled: true
    emailReceivers: [
      {
        name: 'email1'
        emailAddress: mailAddress
      }
    ]
  }
}

output actionGroupId string = actionGroup.id
