resource "local_file" "genesis" {
  content = templatefile("${path.module}/base.tpl", {
    cluster_name          = local.cluster_name
    region                = var.region
    eks_version           = var.eks_version
    vpc_id                = data.aws_ssm_parameter.ssm_vpc_id.value
    vpc_cidr              = data.aws_ssm_parameter.ssm_vpc_cidr.value
    private-subnet-0      = data.aws_ssm_parameter.ssm_private_subnet_0_id.value
    private-subnet-0-cidr = data.aws_ssm_parameter.ssm_private_subnet_0_cidr.value
    private-subnet-1      = data.aws_ssm_parameter.ssm_private_subnet_1_id.value
    private-subnet-1-cidr = data.aws_ssm_parameter.ssm_private_subnet_1_cidr.value
    private-subnet-2      = data.aws_ssm_parameter.ssm_private_subnet_2_id.value
    private-subnet-2-cidr = data.aws_ssm_parameter.ssm_private_subnet_2_cidr.value
    kms                   = data.aws_kms_alias.eks.arn
  })
  filename = "${path.module}/../../../env/${var.team}/${var.env}/${var.region}/${var.infra_id}/${var.cluster}/deploy.yaml"
}



