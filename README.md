# Classic Models GraphQL API with IBM API Connect for GraphQL

This project creates a GraphQL API using IBM API Connect for GraphQL (formerly StepZen) that sits in front of the Classic Models REST API.

## Quick Start

1. **Install dependencies**:
   ```bash
   npm install
   ```

2. **Login to IBM API Connect for GraphQL**:
   ```bash
   ./login.sh
   ```
   (See [Setup Guide](./docs/setup.md) for details)

3. **Set environment variables** (REQUIRED before starting):
   
   **Option 1: Using setup script (recommended)**
   ```bash
   # Create a .env file with your credentials
   echo "STEPZEN_CLASSIC_MODELS_USERNAME=demo" >> .env
   echo "STEPZEN_CLASSIC_MODELS_PASSWORD=demo123" >> .env
   
   # Load environment variables
   source setup-env.sh
   ```
   
   **Option 2: Manual export**
   ```bash
   export STEPZEN_CLASSIC_MODELS_USERNAME=demo
   export STEPZEN_CLASSIC_MODELS_PASSWORD=demo123
   ```
   
   **Important**: These must be set in the same shell session where you run `make start`.

4. **Start the server**:
   ```bash
   make start
   ```

5. **Open GraphiQL** in your browser:
   ```
   http://localhost:5001
   ```

6. **Query product lines with nested products**:
   ```graphql
   query {
     productLines {
       productline
       textdescription
       products(token: "YOUR_ACCESS_TOKEN") {
         productname
         productcode
       }
     }
   }
   ```
   
   Note: The `productLines` query automatically logs in using credentials from environment variables.

## Documentation

- **[Setup Guide](./docs/setup.md)** - Detailed installation and configuration instructions
- **[Authentication Guide](./docs/authentication.md)** - JWT token management and client-side implementation
- **[GraphiQL Authentication](./docs/graphiql-authentication.md)** - How to use authenticated requests in StepZen's GraphiQL interface
- **[API Reference](./docs/api-reference.md)** - Complete GraphQL schema documentation
- **[Examples](./docs/examples.md)** - Example queries and mutations
- **[Troubleshooting](./docs/troubleshooting.md)** - Common issues and solutions
- **[Customization](./docs/customization.md)** - How to customize and extend the API

## Postman Collection

A complete Postman collection with all queries and mutations is available:
- **File**: `Classic-Models-GraphQL.postman_collection.json`
- **Import**: Import this file into Postman to get all requests pre-configured
- **Features**:
  - All queries and mutations organized by entity
  - Automatic token extraction from login response
  - Collection variables for base URL and tokens
  - Example variables for all requests

## Available Commands

```bash
make help      # Show all available commands
make start     # Start StepZen server locally
make deploy    # Deploy to IBM API Connect for GraphQL
make validate  # Validate GraphQL schema
make stop      # Stop StepZen server
```

## Project Overview

This GraphQL API provides a unified interface to the Classic Models REST API, including:

- **Authentication** - Login, signup, token refresh, and user management
- **Products** - Product and product line management
- **Customers** - Customer information and management
- **Orders** - Order tracking and management
- **Order Details** - Detailed order line items
- **Employees** - Employee information
- **Offices** - Office locations
- **Payments** - Payment records

## Key Features

- ✅ Full GraphQL API with queries and mutations
- ✅ JWT authentication with token refresh
- ✅ TLS certificate configuration for secure connections
- ✅ Automatic token management examples
- ✅ Comprehensive error handling

## Resources

- [IBM API Connect for GraphQL Documentation](https://www.ibm.com/docs/en/api-connect)
- [StepZen CLI Documentation](https://stepzen.com/docs) (CLI documentation still uses StepZen branding)
- [GraphQL Best Practices](https://graphql.org/learn/best-practices/)

## Support

For issues and questions:
1. Check the [Troubleshooting Guide](./docs/troubleshooting.md)
2. Review the [Setup Guide](./docs/setup.md) for configuration details
3. See [API Reference](./docs/api-reference.md) for schema documentation
