#--------------------------------------------------------------------------------
#EKS cluster
#-----------

variable "cluster_subnet_ids" {
  type          = list(string)
  description   = "Subnet IDs for EKS cluster"
}

#--------------------------------------------------------------------------------
#EKS node group
#--------------

variable "eks_subnet_ids" {
  type          = list(string)
  description   = "EKS subnets to launch EC2 instances"
}

#--------------------------------------------------------------------------------
#Common variables
#----------------

variable "min_instance_count" {
  type          = number
  description   = "Minimum number of EC2 instances in ASG"
}

variable "desired_instance_count" {
  type          = number
  description   = "Desired number of EC2 instances in ASG"
}

variable "max_instance_count" {
  type          = number
  description   = "Maximum number of EC2 instances in ASG"
}


