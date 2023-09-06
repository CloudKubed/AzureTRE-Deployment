resource "azurerm_policy_definition" "custom_tre_tags" {
  name         = "custom_tre_tags_${local.workspace_resource_name_suffix}"
  display_name = "Azure TRE ${local.workspace_resource_name_suffix}: Custom Tags"
  description  = "Add custom tags to all resources in TRE ${local.workspace_resource_name_suffix}"
  policy_type  = "Custom"
  mode         = "Indexed"

  metadata = <<METADATA
  {
    "category": "Tags",
    "version": "1.0.0"
  }
  METADATA

  policy_rule = jsonencode({
    "if" : {
      "allOf" : [
        {
          "field" : "tags['tre_workspace_id']",
          "equals" : var.tre_resource_id
        },
        {
          "anyOf" : [
            for tag_key, tag_value in local.custom_tags : {
              "field" : "tags['${tag_key}']",
              "notEquals" : tag_value
            }
          ]

        }
      ]
    },
    "then" : {
      "effect" : "modify",
      "details" : {
        "conflictEffect" : "audit",
        "roleDefinitionIds" : [
          "/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"
        ],
        "operations" : [
          for tag_key, tag_value in local.custom_tags : {
            "operation" : "addOrReplace",
            "field" : "tags['${tag_key}']",
            "value" : tag_value
          }
        ]
      }
    }
  })
}

resource "azurerm_resource_group_policy_assignment" "custom_tre_tags" {
  name                 = "custom_tre_tags_${local.workspace_resource_name_suffix}_assignment"
  policy_definition_id = azurerm_policy_definition.custom_tre_tags.id
  resource_group_id    = azurerm_resource_group.ws.id
  location             = var.location

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "subscription_contributor" {
  scope                = azurerm_resource_group.ws.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_resource_group_policy_assignment.custom_tre_tags.identity[0].principal_id
}

resource "azurerm_resource_group_policy_remediation" "custom_tre_tags" {
  name                 = "custom_tre_tags_${local.workspace_resource_name_suffix}_remediation"
  policy_assignment_id = azurerm_resource_group_policy_assignment.custom_tre_tags.id
  resource_group_id    = azurerm_resource_group.ws.id
}
