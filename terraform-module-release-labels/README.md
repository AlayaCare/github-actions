# Terraform Module Release Labels

This action adds standardized release labels to Terraform module repositories. These labels are used to indicate what type of version bump a PR should trigger when merged.

## Labels Added

- `release/major` (🔴 #FF0000) - Indicates the PR should trigger a major release on merge
- `release/minor` (🟡 #FBCA04) - Indicates the PR should trigger a minor release on merge
- `release/patch` (🔵 #C5DEF5) - Indicates the PR should trigger a patch release on merge

## Purpose

These labels work in conjunction with the [Terraform Semantic Versioning Release](../terraform-semver-release/README.md) action to automate versioning of Terraform modules. When a PR is merged, the semantic versioning action will check for these labels and create a new release with the appropriate version bump.

## Usage

### Option 1: Include the workflow directly

Add this workflow to your Terraform module repository:

```yaml
name: Add Release Labels

on:
  workflow_dispatch:
  create:
    branches:
      - main
      - master

jobs:
  add-labels:
    uses: AlayaCare/github-actions/terraform-module-release-labels/.github/workflows/add-release-labels.yml@main
```

### Option 2: Use the script

You can also use the script to add the labels directly:

```bash
curl -s https://raw.githubusercontent.com/AlayaCare/github-actions/main/terraform-module-release-labels/add-release-labels.sh | bash -s -- YOUR_ORG YOUR_REPO
```

Replace `YOUR_ORG` and `YOUR_REPO` with your organization and repository names.
