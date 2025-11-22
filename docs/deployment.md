# Deployment

Guide for deploying the Classic Models GraphQL API to StepZen.

## Prerequisites

- StepZen CLI installed and authenticated
- TLS certificate (`certs/ca.pem`) configured
- StepZen account credentials (optional, for automatic login)

## Local Development

### Start Server Locally

```bash
make start
```

This will:
- Export TLS certificate automatically
- Optionally log in to StepZen CLI (if `.env` has credentials)
- Start server at `http://localhost:5001/classic-models/v1`

### Stop Server

```bash
make stop
```

### Validate Schema

Before deploying, validate your schema:

```bash
make validate
```

## Deploying to StepZen

### Deploy Command

```bash
make deploy
```

This will:
- Export TLS certificate
- Optionally log in to StepZen CLI (if `.env` has credentials)
- Deploy your schema to StepZen

### Manual Deploy

If you prefer to deploy manually:

```bash
# Export certificate
export STEPZEN_CLASSIC_MODELS_CA="$(cat certs/ca.pem)"

# Deploy
stepzen deploy
```

## Environment Configuration

### StepZen CLI Login (Optional)

If you want automatic StepZen CLI login, create a `.env` file:

```bash
STEPZEN_DOMAIN=<your-domain>
STEPZEN_INSTANCE_ID=<your-instance-id>
STEPZEN_API_KEY=<your-api-key>
STEPZEN_INTROSPECTION=<your-introspection-url>
```

The `make start` and `make deploy` commands will automatically use these credentials if present.

### TLS Certificate

The TLS certificate is required and is automatically loaded from `certs/ca.pem`. Ensure this file exists before deploying.

## Deployment Checklist

- [ ] TLS certificate (`certs/ca.pem`) is present and valid
- [ ] GraphQL schema files are valid (run `make validate`)
- [ ] StepZen CLI is installed and authenticated
- [ ] StepZen CLI credentials in `.env` (optional)
- [ ] Test queries work locally

## Post-Deployment

After deploying, you'll receive a StepZen endpoint URL. Update your clients to use this URL instead of localhost.

Test the deployed endpoint with a simple query:

```graphql
query {
  _customers {
    customernumber
    customername
  }
}
```

## Troubleshooting

### Deployment Fails

- Check that all schema files are valid
- Ensure TLS certificate is properly configured
- Verify StepZen CLI authentication
- Check StepZen logs for detailed error messages

### Schema Validation Errors

Run `make validate` to check for schema issues before deploying.

### Certificate Issues

Ensure `certs/ca.pem` exists and contains a valid certificate. See [certs/README.md](../certs/README.md) for certificate setup instructions.

## Production Considerations

- Use environment-specific StepZen configurations
- Set up monitoring and logging
- Configure rate limiting if needed
- Use StepZen's built-in authentication features for production
- Secure your StepZen endpoint with proper access controls

