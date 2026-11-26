output "subnet_id" {
  value       = azurerm_subnet.main.id
  description = "ID til subnettet, til bruk for f.eks. en NIC."
}

output "resource_group_name" {
  description = "Navnet på ressursgruppen som ble opprettet"
  value       = var.resource_group_name
}

output "name_prefix" {
  description = "Navneprefikset alle ressursene dine deler"
  value       = local.name_prefix
}