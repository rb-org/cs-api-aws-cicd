variable "enable_versioning" {
  default = false
}

variable "enable_lifecycle_rule" {
  default = true
}

variable "expiration_days" {
  default = 3
}

variable "default_tags" {
  type = "map"
}

variable "account_id" {}
