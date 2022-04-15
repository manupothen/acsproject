# Instance type
variable "instance_type" {
  default = "t3.medium"
  description = "Type of the instance"
  type        = string
}

# Variable to signal the current environment 
variable "env" {
  default     = "prod"
  type        = string
  description = "prod Environment"
}

# Number of Instances in ASG
variable "instance_count" {
  default     = "3"
  type        = string
  description = "prod Environment Instances Count"
}
