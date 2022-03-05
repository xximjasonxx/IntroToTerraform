
variable service_name {
  type          = string
}

variable resource_group_name {
  type          = string
}

variable location {
  type          = string
}

variable service_tier {
  type          = string
  default       = "Standard"
}

variable service_size {
  type          = string
  default       = "S1"
}

variable app_settings {
  type          = list(object({
    name        = string
    value       = string
  }))
}

variable identity_id {
  type          = string
}