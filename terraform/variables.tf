variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region for infrastructure deployment"
  type        = string
  default     = "us-central1"
}

variable "vpc_name" {
  description = "The name of the HealthConnect VPC"
  type        = string
  default     = "healthconnect-vpc"
}
