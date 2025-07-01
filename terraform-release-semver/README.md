# Terraform Release Semver

This action automatically creates semantic version releases for Terraform modules based on PR labels. When a PR is merged, it will create a new release with a version number incremented according to the label applied to the PR.

## Prerequisites

This action requires the following labels to be available in your repository:
- `release/major` - For breaking changes (increments the major version)
- `release/minor` - For new features (increments the minor version)
- `release/patch` - For bug fixes and small changes (increments the patch version)

You can add these labels using the [Terraform Release Labels](../terraform-release-labels/README.md) action.

## How It Works

1. When a PR is merged to the main branch, this action checks for release labels
2. Based on the label, it determines whether to bump the major, minor, or patch version
3. It creates a new tag with the incremented version
4. It generates a GitHub release with a changelog based on the PR

## Usage

Add this workflow to your Terraform module repository:

```yaml
name: Release

on:
  pull_request:
    types: [closed]
    branches:
      - main
      - master

jobs:
  release:
    if: github.event.pull_request.merged == true
    uses: AlayaCare/github-actions/terraform-release-semver/.github/workflows/semver-release.yml@main
```

## Version Bumping Logic

- If the PR has the `release/major` label, the major version is incremented (e.g., v1.0.0 → v2.0.0)
- If the PR has the `release/minor` label, the minor version is incremented (e.g., v1.0.0 → v1.1.0)
- If the PR has the `release/patch` label or no release label, the patch version is incremented (e.g., v1.0.0 → v1.0.1)

## Example

1. A PR with the label `release/minor` is merged to the main branch
2. The current version is v1.2.3
3. This action will create a new release with version v1.3.0
