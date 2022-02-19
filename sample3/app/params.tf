
variable client_secret {
  type        = string
  sensitive   = true
}

variable location {
  type            = string
  validation {
    condition       = var.location == "eastus" || var.location == "centralus"
    error_message   = "Location must be eastus or centralus."
  }
}

variable environment {
  type            = string
  validation {
    condition       = var.environment == "p" || var.environment == "d"
    error_message   = "Environment must be p (Production) or d (development)."
  }
}

variable app_name {
  type = string
}