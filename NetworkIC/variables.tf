variable "names" {
    type = set(string)
    description = "name of the VMs"
}

variable "location" {
    type = string
    description = "Azure location"
}
variable "resource_group_name" {
    type = string
    description = "name of the resource group"
}
variable "subnet_id" {
    type = string
    description = "id of the subnet"
}
