locals {
  core_vnet                = "vnet-${var.tre_id}"
  core_resource_group_name = "rg-${var.tre_id}"
  storage_account_name     = lower(replace("stg-${var.tre_id}", "-", ""))
  tre_shared_service_tags = {
    tre_id                = var.tre_id
    tre_shared_service_id = var.tre_resource_id
  }
  default_tre_url = "https://${data.azurerm_public_ip.app_gateway_ip.fqdn}"
}
