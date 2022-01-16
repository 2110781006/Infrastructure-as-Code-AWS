variable "winccoaSystemName" {
  type = string
}
variable "winccoaSystemIdx" {
  type = string
}

variable "region" {
  type = string
  default = "us-east-1"
}

variable "min_instances" {
  type = number
  default = 1
}

variable "max_instances" {
  type = number
  default = 1
}

variable "desired_instances" {
  type = number
  default = 1
}