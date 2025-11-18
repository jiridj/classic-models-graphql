#!/bin/bash

# Setup TLS Certificate for StepZen
# This script exports the certificate content as an environment variable

if [ ! -f certs/ca.pem ]; then
    echo "Error: certs/ca.pem not found!"
    echo "Please ensure the certificate file exists."
    exit 1
fi

# Export the certificate content as an environment variable
export STEPZEN_CLASSIC_MODELS_CA="$(cat certs/ca.pem)"

echo "✓ Certificate exported to STEPZEN_CLASSIC_MODELS_CA"
echo ""
echo "To use this in your current shell session, run:"
echo "  source setup-tls.sh"
echo ""
echo "Or add this to your .env file:"
echo "  STEPZEN_CLASSIC_MODELS_CA=\"\$(cat certs/ca.pem)\""
echo ""
echo "Note: For stepzen start (local), you need to export this variable"
echo "      in the same shell session where you run stepzen start"

