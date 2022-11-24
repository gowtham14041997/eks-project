#--------------------------------------------------------------------------------
#VPC
#---

resource "aws_vpc" "opstree_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.tenancy

  tags = {
    Name = var.vpc_name
  }
}

#----------------------------------------------------------------------------------
#Public subnet
#-------------

resource "aws_subnet" "opstree_public_subnet" {
  vpc_id                  = aws_vpc.opstree_vpc.id
  count                   = length(var.public_subnet_cidr)
  cidr_block              = element(var.public_subnet_cidr, count.index)
  availability_zone       = element(var.subnet_az, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.public_subnet_name} - ${element(var.subnet_az, count.index)}"
  }
}

#----------------------------------------------------------------------------------
#Private subnet for EKS
#----------------------

resource "aws_subnet" "opstree_eks_subnet" {
  vpc_id            = aws_vpc.opstree_vpc.id
  count             = length(var.eks_subnet_cidr)
  cidr_block        = element(var.eks_subnet_cidr, count.index)
  availability_zone = element(var.subnet_az, count.index)

  tags = {
    Name = "${var.eks_subnet_name} - ${element(var.subnet_az, count.index)}"
  }
}
