variable "vpc_id" {
  description = "vpc id in which subnet to create"
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}


variable "environment" {
 description = "A default environment"
  type        = string
  default     = "prod"
}

