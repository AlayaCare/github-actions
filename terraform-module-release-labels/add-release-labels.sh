#!/bin/bash

# Default values
ORG=${1:-"AlayaCare"}
REPO=${2:-$(basename $(pwd))}

# Define the release labels to add
declare -A RELEASE_LABELS=(
  ["release/major"]="#FF0000:Indicates the PR should trigger a major release on merge"
  ["release/minor"]="#FBCA04:Indicates the PR should trigger a minor release on merge"
  ["release/patch"]="#C5DEF5:Indicates the PR should trigger a patch release on merge"
)

echo "Adding Terraform module release labels to $ORG/$REPO..."

# Get current labels in the repository
CURRENT_LABELS=$(gh api /repos/$ORG/$REPO/labels)
CURRENT_LABEL_NAMES=$(echo $CURRENT_LABELS | jq -r '.[].name')

# Add or update each release label
for name in "${!RELEASE_LABELS[@]}"; do
  # Split color and description
  IFS=':' read -r color description <<< "${RELEASE_LABELS[$name]}"
  # Remove the # from the color
  color="${color#"#"}"
  
  # Check if label already exists
  if echo "$CURRENT_LABEL_NAMES" | grep -q "^$name$"; then
    echo "Updating label: $name (color: #$color)"
    gh api -X PATCH /repos/$ORG/$REPO/labels/"$name" \
      -f color="$color" \
      -f description="$description" 2>/dev/null || \
      echo "  - Failed to update label '$name'"
  else
    echo "Creating label: $name (color: #$color)"
    gh api -X POST /repos/$ORG/$REPO/labels \
      -f name="$name" \
      -f color="$color" \
      -f description="$description" 2>/dev/null || \
      echo "  - Failed to create label '$name'"
  fi
done

echo "Terraform module release labels have been added successfully!"
