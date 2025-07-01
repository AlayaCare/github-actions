# AlayaCare GitHub Actions

This repository contains a collection of reusable GitHub Actions workflows for AlayaCare repositories.

## Available Actions

### Terraform Module Release Labels

Adds standardized release labels to Terraform module repositories. These labels are used to indicate what type of version bump a PR should trigger when merged.

[View Documentation](./terraform-module-release-labels/README.md)

### Terraform Semantic Versioning Release

Automatically creates semantic version releases for Terraform modules based on PR labels. When a PR is merged, it will create a new release with a version number incremented according to the label applied to the PR.

[View Documentation](./terraform-semver-release/README.md)

## Complete Workflow Example

Here's how to use both actions together in a Terraform module repository:

1. First, add the release labels workflow to your repository:

```yaml
# .github/workflows/add-release-labels.yml
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

2. Then, add the semantic versioning release workflow:

```yaml
# .github/workflows/release.yml
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
    uses: AlayaCare/github-actions/terraform-semver-release/.github/workflows/semver-release.yml@main
```

3. When creating a PR, apply one of the following labels to indicate the type of release:
   - `release/major` - For breaking changes
   - `release/minor` - For new features
   - `release/patch` - For bug fixes and small changes

4. When the PR is merged, a new release will be automatically created with the appropriate version bump.

## Contributing

To add a new action to this repository:

1. Create a new directory for your action
2. Add the workflow files in `.github/workflows/`
3. Include a README.md with usage instructions
4. Add any helper scripts or files needed by the action
5. Update the main README.md to include your new action
