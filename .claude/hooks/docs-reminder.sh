#!/usr/bin/env bash
# Stop hook: when the agent is about to finish with code changed but no doc
# touched, send it back once with a reminder. It decides whether a doc update
# is needed; the hook only makes sure the question was asked.
#
# Exit 0 = let the agent finish. Exit 2 = stderr goes back to the agent.
set -u

input="$(cat)"

# Already reminded in this stop cycle: never loop.
if printf '%s' "$input" | grep -Eq '"stop_hook_active"[[:space:]]*:[[:space:]]*true'; then
  exit 0
fi

cd "${CLAUDE_PROJECT_DIR:-.}" 2>/dev/null || exit 0
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0

changed="$(git status --porcelain --untracked-files=all | cut -c4- | sed 's/.* -> //')"
[ -z "$changed" ] && exit 0

code_changed="$(printf '%s\n' "$changed" | grep -Ev '^(docs/|tests?/|\.github/|\.claude/)|\.md$' || true)"
docs_changed="$(printf '%s\n' "$changed" | grep -E '^(docs/|AGENTS\.md$|REVIEW\.md$|README\.md$)' || true)"

if [ -n "$code_changed" ] && [ -z "$docs_changed" ]; then
  {
    echo "Code changed but no documentation was touched:"
    printf '%s\n' "$code_changed" | head -10 | sed 's/^/  - /'
    echo "If this changes behaviour, a command or the structure, update the spec in"
    echo "docs/specs/, AGENTS.md or an ADR. Update docs/PROGRESS.md if the work"
    echo "continues later. If no doc needs to change, say why in one line and finish."
  } >&2
  exit 2
fi
exit 0
