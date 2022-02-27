
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