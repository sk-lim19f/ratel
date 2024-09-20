output "sg_ids" {
  description = "Security Group IDs"
  value       = module.sg.sg_ids
}

output "sg_names" {
  description = "Security Group Names"
  value       = module.sg.sg_names
}
