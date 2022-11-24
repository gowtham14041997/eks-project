#--------------------------------------------------------------------------------
#VPC
#---

variable "vpc_cidr" {
  type          = string
  description   = "VPC CIDR"
}

variable "tenancy" {
  type          = string
  default       = "default"
  description   = "Instance tenancy"
}

variable "vpc_name" {
  type          = string
  default       = "My VPC"
  description   = "VPC name"
}

#--------------------------------------------------------------------------------
#AZs for public, private and DB subnets
#--------------------------------------

variable "subnet_az" {
  type          = list(string)
  default       = ["ap-south-1a", "ap-south-1b"]
  description   = "AZs for public and private subnets"
}

#----------------------------------------------------------------------------------
#Public subnet for bastion host
#------------------------------

variable "public_subnet_cidr" {
  type          = list(string)
  default       = ["10.0.1.0/24"]
  description   = "public subnet CIDR"
}

variable "public_subnet_name" {
  type          = string
  default       = "My public subnet"
  description   = "public subnet name"
}


#----------------------------------------------------------------------------------
#Private subnet for webservers
#-----------------------------

variable "eks_subnet_cidr" {
  type          = list(string)
  default       = ["10.0.2.0/24", "10.0.3.0/24"]
  description   = "EKS subnet CIDR"
}

variable "eks_subnet_name" {
  type          = string
  default       = "My EKS subnet"
  description   = "EKS subnet name"
}
