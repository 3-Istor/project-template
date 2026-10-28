# One entry point to check everything: agents and CI run `make check`.
# Replace the four commands below with the project's real tools, e.g.
#   LINT = ruff check .        TYPECHECK = mypy src
#   TEST = pytest              BUILD = docker build -t app .
#   ARCH = lint-imports  (Python, import-linter)    ARCH = npx depcruise src (JS/TS)
#   ARCH = vendor/bin/deptrac  (PHP)                 ArchUnit tests in TEST (Java)
# Until then each one prints a warning so nobody mistakes it for a real check.

LINT       = @echo "⚠ lint not configured: set LINT in the Makefile"
TYPECHECK  = @echo "⚠ typecheck not configured: set TYPECHECK in the Makefile"
TEST       = @echo "⚠ tests not configured: set TEST in the Makefile"
BUILD      = @echo "⚠ build not configured: set BUILD in the Makefile"
ARCH       = @echo "⚠ architecture check not configured: set ARCH in the Makefile"

.PHONY: check lint typecheck test build arch adr-lint branch-check help

check: lint typecheck test build arch adr-lint ## Everything the CI checks

lint: ## Linters
	$(LINT)

typecheck: ## Type checks
	$(TYPECHECK)

test: ## Tests (make test T=path/to/test for one)
	$(TEST) $(T)

build: ## Build
	$(BUILD)

arch: ## Layer dependencies (the architecture the ADRs describe)
	$(ARCH)

adr-lint: ## ADR statuses and replacement links
	@python3 scripts/adr_lint.py docs/adr

branch-check: ## Branch name starts with a ticket key
	@scripts/check_branch.sh

help: ## List targets
	@grep -E '^[a-z-]+:.*## ' $(MAKEFILE_LIST) | awk -F':.*## ' '{printf "  %-14s %s\n", $$1, $$2}'
