data "aws_caller_identity" "current" {}

provider "aws" {
  region = var.region
}

### SSM - VALUES ###
data "aws_ssm_parameter" "ssm_vpc_id" {
  name = "${var.infra_id}-${var.env}-${var.cluster}-vpc-id"
}

data "aws_ssm_parameter" "ssm_vpc_cidr" {
  name = "${var.infra_id}-${var.env}-${var.cluster}-vpc-cidr"
}

data "aws_ssm_parameter" "ssm_private_subnet_0_id" {
  name = "${var.infra_id}-${var.env}-${var.cluster}-private-subnet-0"
}

data "aws_ssm_parameter" "ssm_private_subnet_0_cidr" {
  name = "${var.infra_id}-${var.env}-${var.cluster}-private-subnet-0-cidr"
}

data "aws_ssm_parameter" "ssm_private_subnet_1_id" {
  name = "${var.infra_id}-${var.env}-${var.cluster}-private-subnet-1"
}

data "aws_ssm_parameter" "ssm_private_subnet_1_cidr" {
  name = "${var.infra_id}-${var.env}-${var.cluster}-private-subnet-1-cidr"
}

data "aws_ssm_parameter" "ssm_private_subnet_2_id" {
  name = "${var.infra_id}-${var.env}-${var.cluster}-private-subnet-2"
}

data "aws_ssm_parameter" "ssm_private_subnet_2_cidr" {
  name = "${var.infra_id}-${var.env}-${var.cluster}-private-subnet-2-cidr"
}

# SSM END #

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}