# Instance type
variable "instance_type" {
  default = "t2.micro"
  description = "Type of the instance"
  type        = string
}

# Variable to signal the current environment 
variable "env" {
  default     = "dev"
  type        = string
  description = "Non-prod Environment"
}

# Number of Instances in ASG
variable "instance_count" {
  default     = "2"
  type        = string
  description = "Dev Environment Instances Count"
}

# ASG Instance Type
variable "type" {
  default     = "t3.micro"
  type        = string
  description = "Dev Environment Instances Type"
}
