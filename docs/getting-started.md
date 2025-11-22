# Getting Started

This guide will help you set up and run the Classic Models GraphQL API locally.

## Prerequisites

- Node.js (v14 or higher)
- npm or yarn
- StepZen CLI installed (`npm install -g stepzen`)
- TLS certificate file (`certs/ca.pem`)

## Installation

1. **Clone or download the project**

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Set up TLS certificate**

   Get your TLS certificate following the instructions in [certs/README.md](../certs/README.md), then:
   
   ```bash
   # Certificate is automatically loaded by Makefile
   # Or manually export if needed:
   export STEPZEN_CLASSIC_MODELS_CA="$(cat certs/ca.pem)"
   ```

## Running Locally

### Using Make (Recommended)

```bash
# Start the server
make start
```

This will:
- Export the TLS certificate automatically
- Optionally log in to StepZen CLI (if `.env` has credentials)
- Start the StepZen server on `http://localhost:5001`

### Using npm

```bash
# Make sure certificate is exported first
export STEPZEN_CLASSIC_MODELS_CA="$(cat certs/ca.pem)"

# Start StepZen
npm run stepzen:start
```

## Verifying Installation

Once the server is running, you should see output like:

```
✓ Starting...
✓ Deploying schema...

Starting at http://localhost:5001/classic-models/v1
```

You can test the API by visiting the GraphQL playground at:
```
http://localhost:5001/classic-models/v1
```

Or test with a simple query:

```graphql
query {
  _customers {
    customernumber
    customername
  }
}
```

## Available Commands

- `make start` - Start StepZen server locally
- `make stop` - Stop StepZen server
- `make deploy` - Deploy to StepZen
- `make validate` - Validate GraphQL schema
- `make setup` - Export TLS certificate environment variable

## Next Steps

- Check out [Sample Queries](sample-queries.md) for example queries
- Read the [API Reference](api-reference.md) for all available queries
- Review [Authentication](authentication.md) for auth details

