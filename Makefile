.DEFAULT_GOAL := help

test_directory := tests
lint_targets := sftpython $(test_directory)

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

.PHONY: check
check: check-format lint test ## Check the code formatting, lint, and test
