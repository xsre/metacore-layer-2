variable "region" {
  description = "AWS Region Id"
}

variable "infra_id" {
  description = "Shoud be an unique identifier"
}

variable "env" {
  description = "Environment: dev/stag/prod"
}

variable "team" {
  description = "Team who has the ownership"
}

variable "eks_version" {
  description = "EKS Version to deploy"
}