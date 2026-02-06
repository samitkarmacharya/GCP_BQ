variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type        = string
  description = "GCP region"
}

variable "secret_env" {
  type        = map(string)
  description = "Map of environment variables to store in Secret Manager and inject into Cloud Run."
}
