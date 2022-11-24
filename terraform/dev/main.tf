provider "aws" {
  region     = var.region
  profile    = "gowtham"
}

module "my_vpc" {
  source                = "../modules/vpc"

  #VPC
  vpc_cidr              = "10.0.0.0/16"

  #Public subnet CIDR for bastion host
  public_subnet_cidr    = slice(var.subnet_cidrs, 0, 2)

  #Private subnet CIDR for EKS cluster
  eks_subnet_cidr       = slice(var.subnet_cidrs, 2, 4)
}

module "my_route_table" {
  source                      = "../modules/route_table"

  #VPC ID for internet gateway
  vpc_id                      = module.my_vpc.vpc_id

  #Public subnet for NAT gateway
  public_subnet_id            = module.my_vpc.public_subnet_id
  
  #Gateway IDs to create public and private route table
  gateway_id                  = [module.my_route_table.igw_id, module.my_route_table.natgw_id]

  #Public subnets to be associated with public route table
  public_subnet_ids_count     = module.my_vpc.public_subnet_ids_count
  public_subnet_ids           = module.my_vpc.public_subnet_ids

  #Private subnets to be associated with private route table
  eks_subnet_ids_count        = module.my_vpc.eks_subnet_ids_count
  eks_subnet_ids              = module.my_vpc.eks_subnet_ids
}

module "my_eks_cluster" {
  source                         = "../modules/eks"

  #Subnet IDs for EKS cluster and node group
  cluster_subnet_ids             = module.my_vpc.public_subnet_ids
  eks_subnet_ids           	 = module.my_vpc.public_subnet_ids

  #Number of instances in EKS node group
  min_instance_count             = 2
  desired_instance_count         = 2
  max_instance_count             = 2
}

/*
module "my_db" {
  source                      = "../modules/mysql"

  #Subnet IDs to group for DB instances
  db_subnet_ids               = module.my_vpc.public_subnet_ids

  #DB instance configuration
  db_instance_count           = 1
  db_engine                   = "mysql"
  db_instance_class           = "db.t2.micro"
}
*/
