output "subnet_id" {
  value       = azurerm_subnet.main.id
  description = "ID til subnettet, til bruk for f.eks. en NIC."
}

output "resource_group_name" {
  description = "Navnet på ressursgruppen"
  value       = var.resource_group_name
}

output "name_prefix" {
  description = "Navneprefikset alle ressursene deler"
  value       = var.name_prefix
}

output "vnet_name" {
  description = "Navnet på Virtual Network"
  value       = azurerm_virtual_network.main.name
}