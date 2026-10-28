#!/usr/bin/env bash
# Check that a branch name starts with a ticket key, so commits and PRs link
# to their ticket. Usage: scripts/check_branch.sh [branch]
#
# TICKET_PATTERN overrides the expected prefix (extended regex). The default
# accepts "PROJ-42-..." (Jira, Linear) and "42-..." (GitHub or GitLab issue).
set -euo pipefail

branch="${1:-$(git rev-parse --abbrev-ref HEAD)}"
pattern="${TICKET_PATTERN:-^([A-Z][A-Z0-9]+-[0-9]+|[0-9]+)-[a-z0-9]}"

case "$branch" in
  main | master | develop | HEAD | release/* | hotfix/* | dependabot/* | renovate/*)
    exit 0
    ;;
esac

if printf '%s' "$branch" | grep -Eq -- "$pattern"; then
  exit 0
fi

echo "Branch '$branch' does not start with a ticket key." >&2
echo "Expected something like PROJ-42-short-description (pattern: $pattern)." >&2
echo "Rename it: git branch -m <TICKET>-${branch}" >&2
exit 1
