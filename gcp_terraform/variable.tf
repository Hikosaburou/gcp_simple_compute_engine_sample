variable "project_name" {
  description = "GCP Project Name."
  type        = string
}

variable "project_prefix" {
  description = "Prefix code."
  type        = string

  default = "simple-gce"
}

variable "default_region" {
  description = "Default Region."
  type        = string

  default = "asia-northeast1"
}

variable "default_zone" {
  description = "Default VM Instance Zone."
  type        = string

  default = "asia-northeast1-b"
}

variable "instance_type" {
  description = "Cloud IAP Test Instance Type"
  type        = string

  default = "f1-micro"
}

variable "tag_tunnel" {
  description = "Tag value for Cloud IAP tunneling"
  type        = string

  default = "cloud-iap-tunnel"
}

