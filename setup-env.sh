#!/bin/bash

# Setup Environment Variables for StepZen
# This script loads environment variables from .env file if it exists

# Load .env file if it exists
if [ -f .env ]; then
    echo "Loading environment variables from .env file..."
    set -a
    source .env
    set +a
    echo "✓ Environment variables loaded from .env"
else
    echo "Warning: .env file not found"
    echo "Create a .env file with:"
    echo "  STEPZEN_CLASSIC_MODELS_USERNAME=your_username"
    echo "  STEPZEN_CLASSIC_MODELS_PASSWORD=your_password"
    echo ""
    echo "Or export them manually:"
    echo "  export STEPZEN_CLASSIC_MODELS_USERNAME=your_username"
    echo "  export STEPZEN_CLASSIC_MODELS_PASSWORD=your_password"
fi

# Also setup TLS certificate
if [ -f certs/ca.pem ]; then
    export STEPZEN_CLASSIC_MODELS_CA="$(cat certs/ca.pem)"
    echo "✓ TLS certificate exported to STEPZEN_CLASSIC_MODELS_CA"
else
    echo "Warning: certs/ca.pem not found"
fi

echo ""
echo "Current environment variables:"
echo "  STEPZEN_CLASSIC_MODELS_USERNAME: ${STEPZEN_CLASSIC_MODELS_USERNAME:-NOT SET}"
echo "  STEPZEN_CLASSIC_MODELS_PASSWORD: ${STEPZEN_CLASSIC_MODELS_PASSWORD:+SET (hidden)}"
echo "  STEPZEN_CLASSIC_MODELS_CA: ${STEPZEN_CLASSIC_MODELS_CA:+SET}"
echo ""
echo "To use in your current shell, run:"
echo "  source setup-env.sh"

