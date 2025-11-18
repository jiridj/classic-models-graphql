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

3. **Start the server**:
   ```bash
   make start
   ```

4. **Open GraphiQL** in your browser:
   ```
   http://localhost:5001
   ```

5. **Login to get a token** (in GraphiQL):
   ```graphql
   mutation {
     login(username: "demo", password: "demo123") {
       access
       refresh
     }
   }
   ```

6. **Add Authorization header** in GraphiQL:
   - Find the "Headers" section at the bottom
   - Add: `Authorization: Bearer YOUR_ACCESS_TOKEN`
   - See [GraphiQL Authentication Guide](./docs/graphiql-authentication.md) for details

7. **Make authenticated requests** in GraphiQL or via curl:
   ```bash
   curl -X POST http://localhost:5001/api/classic-models/v1 \
     -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
     -H "Content-Type: application/json" \
     -d '{"query": "{ products { productname } }"}'
   ```

## Documentation

- **[Setup Guide](./docs/setup.md)** - Detailed installation and configuration instructions
- **[Authentication Guide](./docs/authentication.md)** - JWT token management and client-side implementation
- **[GraphiQL Authentication](./docs/graphiql-authentication.md)** - How to use authenticated requests in StepZen's GraphiQL interface
- **[API Reference](./docs/api-reference.md)** - Complete GraphQL schema documentation
- **[Examples](./docs/examples.md)** - Example queries and mutations
- **[Troubleshooting](./docs/troubleshooting.md)** - Common issues and solutions
- **[Customization](./docs/customization.md)** - How to customize and extend the API

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
