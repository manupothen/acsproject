# Instance type
variable "instance_type" {
  default = "t3.small"
  description = "Type of the instance"
  type        = string
}

# Variable to signal the current environment 
variable "env" {
  default     = "staging"
  type        = string
  description = "staging Environment"
}

# Number of Instances in ASG
variable "instance_count" {
  default     = "3"
  type        = string
  description = "staging Environment Instances Count"
}

# ASG Instance Type
variable "type" {
  default     = "t3.small"
  type        = string
  description = "staging Environment Instances Type"
}
