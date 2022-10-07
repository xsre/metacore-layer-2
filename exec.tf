resource "null_resource" "deploy" {
  provisioner "local-exec" {
    command = "eksctl create cluster -f ${path.module}/../../../env/${var.team}/${var.env}/${var.zone}/${var.infra_id}/${var.cluster}/deploy.yaml"
  }

  depends_on = [aws_kms_alias.alias,
  local_file.genesis]
}