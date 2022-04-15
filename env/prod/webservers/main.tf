# Define the provider
provider "aws" {
  region = "us-east-1"
}

# Data source for AMI id
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Use remote state to retrieve the data
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "${var.env}-acsproject"
    key    = "${var.env}-network/terraform.tfstate"
    region = "us-east-1"
  }
}

# Define tags locally
locals {
  default_tags = merge(module.globalvars.default_tags, { "env" = var.env })
  prefix = module.globalvars.prefix
  name_prefix  = "${local.prefix}-${var.env}"
}

# Retrieve global variables from the Terraform module
module "globalvars"{
  source = "../../../modules/globalvars"
}

# Load balancer target group
resource "aws_lb_target_group" "test" {
  name     = "${local.name_prefix}-LB-targetgroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.network.outputs.vpc_id
}

# Application Load Balancer
resource "aws_lb" "application_load_balancer" {
  name               = "${local.name_prefix}-Application-LB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = data.terraform_remote_state.network.outputs.public_subnet_id
  enable_deletion_protection = false
}

resource "aws_lb_listener" "lb_listener_http" {
   load_balancer_arn    = aws_lb.application_load_balancer.id
   port                 = "80"
   protocol             = "HTTP"
   default_action {
    target_group_arn = aws_lb_target_group.test.id
    type             = "forward"
  }
}

# Launch Configuration
resource "aws_launch_configuration" "linux" {
  name          = "${local.name_prefix}-Launch-Config"
  image_id      = "ami-0c02fb55956c7d316"
  instance_type = var.instance_type
  security_groups    = [aws_security_group.lb_sg.id]
  key_name      = aws_key_pair.web_key.key_name
  associate_public_ip_address = true
  iam_instance_profile = "LabInstanceProfile"
  user_data = filebase64("${path.module}/install_httpd.sh")
}

# Auto Scaling Group
resource "aws_autoscaling_group" "asg" {
  name               = "${local.name_prefix}-project-ASG"
  desired_capacity   = 3
  max_size           = 4
  min_size           = 1
  launch_configuration = aws_launch_configuration.linux.name
  vpc_zone_identifier       = [data.terraform_remote_state.network.outputs.private_subnet_id[0],data.terraform_remote_state.network.outputs.private_subnet_id[1],data.terraform_remote_state.network.outputs.private_subnet_id[2]]
  depends_on = [aws_lb.application_load_balancer]
  target_group_arns = [aws_lb_target_group.test.arn]
}

resource "aws_autoscaling_policy" "asg_policy" {
  autoscaling_group_name = aws_autoscaling_group.asg.name
  name                   = "${local.name_prefix}-Autoscaling"
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
  predefined_metric_specification {
    predefined_metric_type = "ASGAverageCPUUtilization"
  }
  target_value = 10
}
}

# Bastion host VM
resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.web_key.key_name
  subnet_id                   = data.terraform_remote_state.network.outputs.public_subnet_id[1]
  security_groups             = [aws_security_group.web_sg_bastion.id]
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-Bastion"
    }
  )
}

# Adding SSH key to Amazon EC2
resource "aws_key_pair" "web_key" {
  key_name   = local.name_prefix
  public_key = file("${local.name_prefix}.pub")
}

# Security Group for Bastion VM
resource "aws_security_group" "web_sg_bastion" {
  name        = "allow_ssh_bastion"
  description = "Allow SSH inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    description      = "SSH from admin"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-Sg-Bastion"
    }
  )
}

# Security Group for Load balancer
resource "aws_security_group" "lb_sg" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-SG-LB"
    }
  )
}
