package terraform.security

# allowed instance types
allowed := {"t2.micro"}

# Check resource_changes (plan JSON structure)
deny contains msg if {
  some i
  rc := input.resource_changes[i]
  rc.type == "aws_instance"
  it := rc.change.after.instance_type
  not it in allowed
  msg := sprintf("aws_instance %v uses non-allowed instance_type %v (resource_changes)", [rc.address, it])
}

# Check planned_values.root_module.resources (alternate plan shape)
deny contains msg if {
  some i
  r := input.planned_values.root_module.resources[i]
  r.type == "aws_instance"
  it := r.values.instance_type
  not it in allowed
  msg := sprintf("aws_instance %v uses non-allowed instance_type %v (planned_values)", [r.address, it])
}
