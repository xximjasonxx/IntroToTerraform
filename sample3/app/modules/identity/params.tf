
variable app_name {
  type        = string
}

variable environment {
  type        = string
}

variable location {
  type        = string
}

variable resource_group_name {
  type        = string
}

variable role_assignments {
  type        = map(object({
    role_definition_name = string
    resource_id          = string
  }))
}