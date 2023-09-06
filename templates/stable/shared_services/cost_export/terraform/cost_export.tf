
resource "azurerm_storage_account" "costs" {
  name                     = lower(replace("stgcost${var.tre_id}", "-", ""))
  resource_group_name      = data.azurerm_resource_group.core.name
  location                 = data.azurerm_resource_group.core.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.tre_shared_service_tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_storage_container" "costs" {
  name                 = "costs"
  storage_account_name = azurerm_storage_account.costs.name
}

resource "azurerm_subscription_cost_management_export" "tre_costs" {
  name                         = "tre_daily_costs"
  subscription_id              = data.azurerm_subscription.current.id
  recurrence_type              = "Daily"
  recurrence_period_start_date = timestamp()
  recurrence_period_end_date   = timeadd(timestamp(), "175200h") #20 years

  export_data_storage_location {
    container_id     = azurerm_storage_container.costs.resource_manager_id
    root_folder_path = ""
  }

  export_data_options {
    type       = "Usage"
    time_frame = "MonthToDate"
  }

  lifecycle {
    ignore_changes = [
      recurrence_period_start_date,
      recurrence_period_end_date
    ]
  }

}
