locals {
  short_workspace_id             = substr(var.tre_resource_id, -4, -1)
  workspace_resource_name_suffix = "${var.tre_id}-ws-${local.short_workspace_id}"
  storage_name                   = lower(replace("stg${substr(local.workspace_resource_name_suffix, -8, -1)}", "-", ""))
  keyvault_name                  = lower("kv-${substr(local.workspace_resource_name_suffix, -20, -1)}")
  redacted_senstive_value        = "REDACTED"
  tre_workspace_tags = merge(local.workspace_tags, local.custom_tags)
  workspace_tags = {
    tre_id           = var.tre_id
    tre_workspace_id = var.tre_resource_id
  }
  custom_tags = lower(var.custom_tag_value_1) != "" ? local.custom_tags1 : local.custom_tags2
  
  custom_tags1 = merge({
    (var.custom_tag_key_1) = var.custom_tag_value_1
  }, local.custom_tags3)

  custom_tags2 = merge({
    (var.custom_tag_key_2) = var.custom_tag_value_2
    (var.custom_tag_key_3) = var.custom_tag_value_3
    (var.custom_tag_key_4) = var.custom_tag_value_4
  }, local.custom_tags3)
  
  custom_tags3 = {
    (var.custom_tag_key_5) = var.custom_tag_value_5
    (var.custom_tag_key_6) = var.custom_tag_value_6
  }
}
