// terraform {
//   required_providers {
//     azurerm = {
//       source  = "hashicorp/azurerm"
//       version = "=2.46.0"
//     }
//   }
// }
terraform {
  required_version = ">=1.0"

  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.46.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  //subscription_id = ""
  features {}
}

resource "azurerm_resource_group" "akshay_rsg" {
  name     = "akshay_rsg"
  location = "Central India"
}
module "virtual-network" {
  source                        = "./VirtualNET"
  virtual_network_name          = var.virtual_network_name
  resource_group_name           = azurerm_resource_group.akshay_rsg.name
  location                      = var.location
  virtual_network_address_space = var.virtual_network_address_space
  subnet_name                   = var.subnet_name
  subnet_address_prefix         = var.subnet_address_prefix
  depends_on = [
    azurerm_resource_group.akshay_rsg
  ]

}

resource "azurerm_network_interface" "nic" {

 for_each            = toset(var.names)
    name                = "${each.value}-nic"
    location            = var.location
    resource_group_name = azurerm_resource_group.akshay_rsg.name
    ip_configuration {
       name                          = "ipconfiguration1"
        subnet_id                     = module.virtual-network.subnet_id    
       private_ip_address_allocation = "Dynamic"
         }
     depends_on = [
     azurerm_resource_group.akshay_rsg
   ]
}

module "VMachine" {
    source   = "./VMachine"
  for_each = toset(var.names)
   vmname   = each.value

  location              = var.location
   resource_group_name   = azurerm_resource_group.akshay_rsg.name
    network_interface_ids = [
           azurerm_network_interface.nic[each.key].id,
]
   vm_size               = var.vm_size
   os_disk_type          = var.os_disk_type
   admin_usename         = var.admin_usename
   admin_password        = var.admin_password
   image_publisher       = var.image_publisher
   image_offer           = var.image_offer
   image_sku             = var.image_sku

depends_on = [
     azurerm_resource_group.akshay_rsg
   ]
 }
resource "random_pet" "azurerm_kubernetes_cluster_name" {
  prefix = "cluster"
}

resource "random_pet" "azurerm_kubernetes_cluster_dns_prefix" {
  prefix = "dns"
}

resource "azurerm_kubernetes_cluster" "k8s" {
  location            = azurerm_resource_group.akshay_rsg.location
  name                = random_pet.azurerm_kubernetes_cluster_name.id
  resource_group_name = azurerm_resource_group.akshay_rsg.name
  dns_prefix          = random_pet.azurerm_kubernetes_cluster_dns_prefix.id

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "agentpool"
    vm_size    = "Standard_D2_v2"
    node_count = var.node_count
  }
  linux_profile {
    admin_username = var.username

    ssh_key {
      key_data = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
    }
  }
  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
}