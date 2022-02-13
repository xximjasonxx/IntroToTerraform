
variable app_name {
  type    = string
}

variable environment {
  type    = string
}

variable resource_group_name {
  type    = string
}

variable location {
  type    = string
}

variable plan_kind {
  type    = string
  validation {
    condition       = var.plan_kind == "Linux" || var.plan_kind == "Windows"
    error_message   = "Plan Kind must be 'Linux' or 'Windows'."
  }
}

variable plan_tier {
  type    = string
  validation {
    condition       = var.plan_tier == "Basic" || var.plan_tier == "Standard"
    error_message   = "Plan Tier must be 'Basic' or 'Standard'."
  }
}

variable plan_size {
  type   = string
  validation {
    condition       = var.plan_size == "B1" || var.plan_size == "S1"
    error_message   = "Allowed Plan Sizes are B1 for Basic Tier or S1 for Standard Tier."
  }
}