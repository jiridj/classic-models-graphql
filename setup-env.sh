#!/bin/bash

# Setup Environment Variables for StepZen
# This script exports the TLS certificate as an environment variable

# Setup TLS certificate
if [ -f certs/ca.pem ]; then
    export STEPZEN_CLASSIC_MODELS_CA="$(cat certs/ca.pem)"
    echo "✓ TLS certificate exported to STEPZEN_CLASSIC_MODELS_CA"
else
    echo "Warning: certs/ca.pem not found"
    echo "Please ensure the certificate file exists in certs/ca.pem"
    exit 1
fi

echo ""
echo "Current environment variables:"
echo "  STEPZEN_CLASSIC_MODELS_CA: ${STEPZEN_CLASSIC_MODELS_CA:+SET}"
echo ""
echo "To use in your current shell, run:"
echo "  source setup-env.sh"
echo ""
echo "Note: Username and password are hardcoded in auth.graphql"
echo "      No .env file is required for this project"

