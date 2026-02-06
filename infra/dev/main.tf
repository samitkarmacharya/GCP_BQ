terraform {
  required_version = ">= 1.6.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

locals {
  cloud_run_service_name = "demo-dag-service"
  artifact_repo_id       = "cloud-run"
  cloud_run_image        = "${var.region}-docker.pkg.dev/${var.project_id}/${local.artifact_repo_id}/demo-dag:latest"
}

resource "google_artifact_registry_repository" "cloud_run" {
  location      = var.region
  repository_id = local.artifact_repo_id
  format        = "DOCKER"
}

resource "google_service_account" "cloud_run" {
  account_id   = "cloud-run-demo-dag"
  display_name = "Cloud Run Demo DAG"
}

resource "google_secret_manager_secret" "env" {
  for_each = var.secret_env

  secret_id = each.key
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "env" {
  for_each = var.secret_env

  secret      = google_secret_manager_secret.env[each.key].id
  secret_data = each.value
}

resource "google_secret_manager_secret_iam_member" "env_accessor" {
  for_each = var.secret_env

  secret_id = google_secret_manager_secret.env[each.key].id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.cloud_run.email}"
}

resource "google_cloud_run_v2_service" "demo_dag" {
  name     = local.cloud_run_service_name
  location = var.region

  template {
    service_account = google_service_account.cloud_run.email

    containers {
      image = local.cloud_run_image

      dynamic "env" {
        for_each = var.secret_env
        content {
          name = env.key
          value_source {
            secret_key_ref {
              secret  = google_secret_manager_secret.env[env.key].secret_id
              version = "latest"
            }
          }
        }
      }
    }
  }
}

resource "google_cloud_run_v2_service_iam_member" "public_invoker" {
  location = google_cloud_run_v2_service.demo_dag.location
  name     = google_cloud_run_v2_service.demo_dag.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

output "cloud_run_url" {
  value       = google_cloud_run_v2_service.demo_dag.uri
  description = "Public URL for the demo Cloud Run service."
}
