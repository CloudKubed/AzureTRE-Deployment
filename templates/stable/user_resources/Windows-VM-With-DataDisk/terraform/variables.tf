variable "workspace_id" {}
variable "tre_id" {}
variable "parent_service_id" {}
variable "tre_resource_id" {}
variable "image" {}
variable "vm_size" {}
variable "data_disk" {
  type = number
  default = 50
}
variable "shared_storage_access" {
  type = bool
}
variable "shared_storage_name" {}
variable "image_gallery_id" {
  default = ""
}
