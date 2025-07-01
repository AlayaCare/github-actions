# AlayaCare GitHub Actions

This repository contains a collection of reusable GitHub Actions workflows for AlayaCare repositories.

## Available Actions

### Terraform Module Release Labels

Adds standardized release labels to Terraform module repositories. These labels are used to indicate what type of version bump a PR should trigger when merged.

[View Documentation](./terraform-module-release-labels/README.md)

## Usage

Each action has its own documentation with specific usage instructions. In general, you can use these actions in your workflows by referencing them like this:

```yaml
name: My Workflow

on:
  workflow_dispatch:

jobs:
  my-job:
    uses: AlayaCare/github-actions/<action-name>/.github/workflows/<workflow-file>.yml@main
```

## Contributing

To add a new action to this repository:

1. Create a new directory for your action
2. Add the workflow files in `.github/workflows/`
3. Include a README.md with usage instructions
4. Add any helper scripts or files needed by the action
5. Update the main README.md to include your new action
