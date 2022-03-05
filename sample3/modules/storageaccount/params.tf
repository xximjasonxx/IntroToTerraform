
variable resource_group_name {
  type        = string
}

variable location {
  type        = string
}

variable department_code {
  type        = string
  validation {
    condition = length(var.department_code) == 3
    error_message = "Department code must be 3 characters long."
  }
}

variable number_code {
  type        = string
  default     = "001"
  validation {
    condition = length(var.number_code) == 3
    error_message = "Number code must be 3 characters long."
  }
}

variable containers {
  type        = map(object({
    principal_id = string
    role_name    = string
  }))
}