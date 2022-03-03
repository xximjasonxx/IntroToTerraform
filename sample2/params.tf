
variable location {
  type            = string
  default         = "eastus"
}

variable departmentCode {
  type            = string
  validation {
    condition       = length(var.departmentCode) == 3
    error_message   = "Department code must be 3 characters."
  }
}

variable environmentCode {
  type            = string
  validation {x`
    condition       = length(var.environmentCode) == 1 && (var.environmentCode == "p" || var.environmentCode == "d")
    error_message   = "Environment code must be 2 characters and must be 'p' or 'd'."
  }
}

variable numberCode {
  type            = number
  default         = 2
  validation {
    condition       = var.numberCode > 1
    error_message   = "Number code must be greater than 1."
  }
}

variable planSize {
  type            = string
  validation {
    condition       = var.planSize == "B1" || var.planSize == "S1"
    error_message   = "Plan suffix must be 'B1' or 'S1'."
  }
}