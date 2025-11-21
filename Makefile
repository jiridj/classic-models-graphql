.PHONY: help setup start deploy validate stop

# Default target
help:
	@echo "Available commands:"
	@echo "  make setup     - Export TLS certificate environment variable"
	@echo "  make start     - Start StepZen server locally"
	@echo "  make deploy    - Deploy to StepZen"
	@echo "  make validate  - Validate GraphQL schema"
	@echo "  make stop      - Stop StepZen server (if running)"
	@echo ""
	@echo "Environment variables:"
	@echo "  STEPZEN_CLASSIC_MODELS_CA      - TLS certificate (auto-set by setup)"
	@echo "  STEPZEN_CLASSIC_MODELS_USERNAME - Username for authentication (required)"
	@echo "  STEPZEN_CLASSIC_MODELS_PASSWORD - Password for authentication (required)"
	@echo "  JWT_TOKEN                      - JWT token for authenticated requests"

# Export TLS certificate
setup:
	@if [ ! -f certs/ca.pem ]; then \
		echo "Error: certs/ca.pem not found!"; \
		exit 1; \
	fi
	@export STEPZEN_CLASSIC_MODELS_CA="$$(cat certs/ca.pem)"; \
	echo "✓ TLS certificate exported to STEPZEN_CLASSIC_MODELS_CA"
	@echo ""
	@echo "To use in your current shell, run:"
	@echo "  export STEPZEN_CLASSIC_MODELS_CA=\"\$$(cat certs/ca.pem)\""
	@echo "  make start"

# Start StepZen server locally
start: setup
	@echo "Starting StepZen server..."
	@echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	@if [ -f .env ]; then \
		set -a; \
		. .env; \
		set +a; \
		export STEPZEN_CLASSIC_MODELS_CA="$$(cat certs/ca.pem)"; \
		echo "✓ Loaded environment variables from .env"; \
		echo ""; \
		echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"; \
		echo "Logging in to StepZen..."; \
		echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"; \
		if [ -f login.sh ]; then \
			bash login.sh || exit 1; \
		else \
			echo "⚠ login.sh not found, skipping automatic login"; \
		fi; \
		echo ""; \
		echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"; \
		echo "Environment Variables Status:"; \
		echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"; \
		echo "Checking required environment variables:"; \
		if [ -n "$$STEPZEN_CLASSIC_MODELS_USERNAME" ]; then \
			echo "  ✓ STEPZEN_CLASSIC_MODELS_USERNAME is set (value: $$STEPZEN_CLASSIC_MODELS_USERNAME)"; \
		else \
			echo "  ✗ STEPZEN_CLASSIC_MODELS_USERNAME is NOT set"; \
			echo "    Add it to .env file: STEPZEN_CLASSIC_MODELS_USERNAME=your_username"; \
		fi; \
		if [ -n "$$STEPZEN_CLASSIC_MODELS_PASSWORD" ]; then \
			echo "  ✓ STEPZEN_CLASSIC_MODELS_PASSWORD is set (value: [HIDDEN])"; \
		else \
			echo "  ✗ STEPZEN_CLASSIC_MODELS_PASSWORD is NOT set"; \
			echo "    Add it to .env file: STEPZEN_CLASSIC_MODELS_PASSWORD=your_password"; \
		fi; \
		if [ -n "$$STEPZEN_CLASSIC_MODELS_CA" ]; then \
			echo "  ✓ STEPZEN_CLASSIC_MODELS_CA is set (length: $$(echo -n "$$STEPZEN_CLASSIC_MODELS_CA" | wc -c | tr -d ' ') chars)"; \
		else \
			echo "  ✗ STEPZEN_CLASSIC_MODELS_CA is NOT set"; \
		fi; \
		echo ""; \
		echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"; \
		echo "Starting StepZen..."; \
		echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"; \
		STEPZEN_CLASSIC_MODELS_CA="$$(cat certs/ca.pem)" \
		STEPZEN_CLASSIC_MODELS_USERNAME="$$STEPZEN_CLASSIC_MODELS_USERNAME" \
		STEPZEN_CLASSIC_MODELS_PASSWORD="$$STEPZEN_CLASSIC_MODELS_PASSWORD" \
		stepzen start; \
	else \
		echo "⚠ .env file not found"; \
		echo "  Create .env file with STEPZEN_CLASSIC_MODELS_USERNAME and STEPZEN_CLASSIC_MODELS_PASSWORD"; \
	fi

# Deploy to StepZen
deploy: setup
	@echo "Deploying to StepZen..."
	@export STEPZEN_CLASSIC_MODELS_CA="$$(cat certs/ca.pem)"; \
	stepzen deploy

# Validate GraphQL schema
validate:
	@echo "Validating GraphQL schema..."
	@stepzen validate .

# Stop StepZen server
stop:
	@echo "Stopping StepZen server..."
	@pkill -f "stepzen start" || echo "No StepZen server running"

