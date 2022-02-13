
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

variable account_kind {
  type        = string
  validation {
    condition       = var.account_kind == "StorageV2" || var.account_kind == "BlobStorage"
    error_message   = "Account Kind must be StorageV2 or BlobStorage."
  }
}

variable containers {
  type        = set(string)
}