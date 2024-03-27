provider "aws"{
    region  = "us-east-1"
}

#resources - something we want to create
#variables - substitutes for values , makes it reusable

variable "subnet_cidr_block" {
  description = "it hold value of cidr block for subnet"

}

variable "vpc_cidr_block" {
  description = "it hold value of cidr block for vpc"
}
resource "aws_vpc" "demo-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name : "demo"
  }
}

resource "aws_subnet" "demo-subnet-1" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = var.subnet_cidr_block
  availability_zone = "us-east-1a"

  tags = {
    Name = "Main"
  }
}

#DataSources - Helps to query existing resources

data "aws_vpc" "query-existing-vpc" {
  default = true
}

resource "aws_subnet" "demo-subnet-2" {
  vpc_id     = data.aws_vpc.query-existing-vpc.id
  cidr_block = "172.31.128.0/19"
  availability_zone = "us-east-1a"

  tags = {
    Name = "default-new"
  }
}

#outputs= displays value of the attribute of the resource

output "q-vpc-id" {
  value = data.aws_vpc.query-existing-vpc.id
}

output "q-subnet-id" {
  value = aws_subnet.demo-subnet-1.id
}

output "demo-vpc-tenancy" {
  value = aws_vpc.demo-vpc.instance_tenancy
}