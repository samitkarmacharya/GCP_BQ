# LookML Project

This folder contains LookML project scaffolding.

## Structure

- `manifest.lkml`: project metadata
- `models/`: model files
- `views/`: view files

## Quickstart

1. Update the connection name in `models/gcp_bq.model.lkml`.
2. Update `sql_table_name` in `views/sample_sales.view.lkml` to your BigQuery table.
3. Import this repo into Looker and select the `gcp_bq` project.
