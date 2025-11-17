#!/bin/bash

# StepZen Login Script
# This script reads StepZen credentials from .env file and logs in

# Check if .env file exists
if [ ! -f .env ]; then
    echo "Error: .env file not found!"
    echo "Please create a .env file with the following variables:"
    echo "  STEPZEN_DOMAIN=<your-domain>"
    echo "  STEPZEN_INSTANCE_ID=<your-instance-id>"
    echo "  STEPZEN_API_KEY=<your-api-key>"
    echo "  STEPZEN_INTROSPECTION=<your-introspection-url>"
    exit 1
fi

# Load environment variables from .env file
export $(grep -v '^#' .env | xargs)

# Check if all required variables are set
if [ -z "$STEPZEN_DOMAIN" ]; then
    echo "Error: STEPZEN_DOMAIN is not set in .env file"
    exit 1
fi

if [ -z "$STEPZEN_INSTANCE_ID" ]; then
    echo "Error: STEPZEN_INSTANCE_ID is not set in .env file"
    exit 1
fi

if [ -z "$STEPZEN_API_KEY" ]; then
    echo "Error: STEPZEN_API_KEY is not set in .env file"
    exit 1
fi

if [ -z "$STEPZEN_INTROSPECTION" ]; then
    echo "Error: STEPZEN_INTROSPECTION is not set in .env file"
    exit 1
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

