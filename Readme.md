# GCP_BQ

Terraform-based Google Cloud infrastructure (dev + prod) with GitHub Actions CI/CD.

## Quickstart

1. Configure GitHub Actions Secrets:

- `GCP_SERVICE_ACCOUNT_KEY` (full JSON key)
- `GCP_PROJECT_ID`
- `GCP_REGION`

2. Add or update Terraform resources:

- `infra/dev`
- `infra/prod`

3. Workflow behavior:

- Pull requests: `terraform fmt` + `terraform plan` for dev and prod
- Push to `main`: `terraform apply` for dev and prod

## Repo Layout

- `infra/dev` Terraform config for dev
- `infra/prod` Terraform config for prod
- `.github/workflows/terraform.yml` CI/CD workflow

## Notes

Use GitHub Environments named `dev` and `prod` if you want approval gates for apply.
