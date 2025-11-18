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
	@echo "  STEPZEN_CLASSIC_MODELS_CA - TLS certificate (auto-set by setup)"
	@echo "  JWT_TOKEN                 - JWT token for authenticated requests"

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
	@export STEPZEN_CLASSIC_MODELS_CA="$$(cat certs/ca.pem)"; \
	stepzen start

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

