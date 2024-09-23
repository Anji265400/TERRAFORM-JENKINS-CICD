variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}
variable "key_name" {
  description = " SSH keys to connect to ec2 instance"
  default     = "anju-utility-key-pair-us-east-1"
}
variable "instance_type" {
  description = "instance type for ec2"
  default     = "t2.medium"
}
variable "ami_id" {
  description = "AMI for Ubuntu Ec2 instance"
  default     = "ami-0e86e20dae9224db8"
}
variable "bucketname" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "anji-utility-bucket1"  # Replace with your default value
}

variable "acl" {
  description = "The ACL (Access Control List) for the S3 bucket"
  type        = string
  default     = "private"
}
