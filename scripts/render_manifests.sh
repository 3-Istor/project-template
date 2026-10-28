#!/usr/bin/env bash
# Print the Kubernetes manifests of the project as one YAML stream:
# `helm template` when the path is a chart, the YAML files otherwise.
set -euo pipefail

path="${1:?usage: render_manifests.sh <chart-or-folder>}"
if [ -f "$path/Chart.yaml" ]; then
  helm template ci "$path"
else
  find "$path" -type f \( -name '*.yaml' -o -name '*.yml' \) -print0 | sort -z |
    while IFS= read -r -d '' file; do
      printf -- '---\n'
      cat "$file"
    done
fi
