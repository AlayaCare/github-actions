#!/bin/bash

# Check if organization name is provided
if [ -z "$1" ]; then
  echo "Usage: $0 organization_name \"repo1 repo2 repo3\""
  echo "Example: $0 AlayaCare \"terraform-aws-s3 terraform-aws-ec2\""
  exit 1
fi

ORG=$1
REPOS=$2

# If no specific repos are provided, get all repos in the organization that start with terraform-
if [ -z "$REPOS" ]; then
  echo "No repositories specified. Getting all Terraform module repositories in $ORG..."
  REPOS=$(gh repo list $ORG --limit 1000 --json name --jq '.[].name | select(startswith("terraform-"))')
fi

# Process each repository
for REPO in $REPOS; do
  echo "Processing repository: $ORG/$REPO"
  ./add-release-labels.sh $ORG $REPO
  echo "-----------------------------------"
done

echo "All repositories processed!"
