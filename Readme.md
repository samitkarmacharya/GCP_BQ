# GCP_BQ

Terraform-based Google Cloud infrastructure (dev + prod) with GitHub Actions CI/CD.

## Quickstart

1. Configure GitHub Actions Secrets:

- `GCP_SERVICE_ACCOUNT_KEY` (full JSON key)
- `GCP_PROJECT_ID`
- `GCP_REGION`
- `TF_VAR_SECRET_ENV` (JSON map of secret env vars, e.g. `{\"APP_NAME\":\"demo-dag\",\"MESSAGE_PREFIX\":\"Hello\"}`)

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
- `Composer/` Cloud Run app + Dockerfile (demo-dag)
- `lookml/` LookML project scaffolding

## Notes

Use GitHub Environments named `dev` and `prod` if you want approval gates for apply.

## Cloud Run (dev)

The dev environment provisions a public Cloud Run service using the Docker image:

`<region>-docker.pkg.dev/<project>/cloud-run/demo-dag:latest`

Build and push the image before applying:

```bash
gcloud auth configure-docker <region>-docker.pkg.dev
docker build -t <region>-docker.pkg.dev/<project>/cloud-run/demo-dag:latest Composer
docker push <region>-docker.pkg.dev/<project>/cloud-run/demo-dag:latest
```
