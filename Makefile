.DEFAULT_GOAL := help

define BROWSER_PYSCRIPT
import sys
import webbrowser
from pathlib import Path

webbrowser.open("file://" + str(Path(sys.argv[1]).resolve()))
endef
export BROWSER_PYSCRIPT
open_browser := python -c "$$BROWSER_PYSCRIPT"

test_directory := tests
source_directory := sftpython
lint_targets := $(source_directory) $(test_directory)
docs_directory := docs
docs_build_path := $(docs_directory)/_build
docs_source_path := $(docs_directory)/src

.PHONY: help
help: ## Display this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

.PHONY: test
test: ## Run the automated tests
	@echo "tests:"
	@poetry run pytest $(test_directory)

.PHONY: lint
lint: ## Run the code linters to check code quality
	@echo "mypy:"
	@poetry run mypy $(lint_targets)
	@echo ""
	@echo "pylint:"
	@poetry run pylint $(lint_targets)

.PHONY: format
format: ## Run the code formatters
	@echo "black:"
	@poetry run black $(lint_targets)
	@echo ""
	@echo "isort:"
	@poetry run isort $(lint_targets)

.PHONY: check-format
check-format: ## Check the code formatting
	@echo "black:"
	@poetry run black $(lint_targets) --check
	@echo ""
	@echo "isort:"
	@poetry run isort $(lint_targets) --check

.PHONY: build-docs
build-docs: ## Build the automated documentation
	@echo "Cleaning old documentation"
	@rm -rf $(docs_source_path) $(docs_build_path)
	@echo "Building documentation"
	@poetry run sphinx-apidoc --separate -o $(docs_source_path) $(source_directory)
	@poetry run sphinx-build -n -W --keep-going $(docs_directory) $(docs_build_path)

.PHONY: serve-docs
serve-docs: build-docs ## Build the automated documentation and open in a browser
	@$(open_browser) $(docs_build_path)/index.html

.PHONY: check
check: check-format lint test build-docs ## Run all automated code checks
