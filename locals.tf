locals {
  cluster_name = "${var.infra_id}-${var.env}"

  tags = {
    owner                                = var.team
    environment                          = var.env
    cluster_name                         = local.cluster_name
    "kubernetes.io/cluster/cluster-name" = "shared"
  }
}