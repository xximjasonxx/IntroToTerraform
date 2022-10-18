
variable app_name {
  type            = string
}

variable location {
  type            = string
}

variable resource_group_name {
  type            = string
}

variable plan_size {
  type            = string
  validation {
    condition       = var.plan_size == "B1" || var.plan_size == "S1"
    error_message   = "Plan suffix must be 'B1' or 'S1'."
  }
}

variable container_image_name {
  type            = string
}