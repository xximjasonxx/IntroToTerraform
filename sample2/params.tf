
variable departmentCode {
  type            = string
  validation {
    condition       = length(var.departmentCode) == 3
    error_message   = "Department code must be 3 characters"
  }
}

variable numberOfContainers {
  type            = number
  validation {
    condition       = var.numberOfContainers > 0
    error_message   = "Number of containers must be greater than 0"
  }
}