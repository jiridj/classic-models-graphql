#!/bin/bash

# StepZen Login Script
# This script reads StepZen credentials from .env file and logs in
# Optional: Only runs if .env exists with StepZen CLI credentials

# Check if .env file exists
if [ ! -f .env ]; then
    echo "⚠ .env file not found - skipping StepZen CLI login"
    echo "   (This is optional - only needed for StepZen CLI authentication)"
    exit 0
fi

# Load environment variables from .env file
set -a
source .env 2>/dev/null || true
set +a

# Check if all required variables are set
if [ -z "$STEPZEN_DOMAIN" ] || [ -z "$STEPZEN_INSTANCE_ID" ] || [ -z "$STEPZEN_API_KEY" ] || [ -z "$STEPZEN_INTROSPECTION" ]; then
    echo "⚠ StepZen CLI credentials not found in .env file"
    echo "   Skipping StepZen CLI login (this is optional)"
    echo ""
    echo "   To enable StepZen CLI login, add to .env:"
    echo "     STEPZEN_DOMAIN=<your-domain>"
    echo "     STEPZEN_INSTANCE_ID=<your-instance-id>"
    echo "     STEPZEN_API_KEY=<your-api-key>"
    echo "     STEPZEN_INTROSPECTION=<your-introspection-url>"
    exit 0
fi

# Run stepzen login command
echo "Logging in to StepZen..."
echo "Domain: $STEPZEN_DOMAIN"
echo "Instance ID: $STEPZEN_INSTANCE_ID"
echo "Introspection: $STEPZEN_INTROSPECTION"
echo ""

stepzen login "$STEPZEN_DOMAIN" \
    -i "$STEPZEN_INSTANCE_ID" \
    -k "$STEPZEN_API_KEY" \
    --introspection "$STEPZEN_INTROSPECTION"

if [ $? -eq 0 ]; then
    echo ""
    echo "✓ Successfully logged in to StepZen!"
else
    echo ""
    echo "✗ Login failed. Please check your credentials."
    exit 1
fi

