# Classic Models GraphQL API

A GraphQL API for the Classic Models database built with StepZen, providing type-safe access to customers, orders, products, and sales analytics.

## Features

- 🚀 **GraphQL API** - Type-safe queries with nested relationships
- 🔐 **Authentication** - Token-based authentication via REST API
- 📦 **Nested Queries** - Customers with orders, order details, and payments
- 🛍️ **Product Catalog** - Product lines with nested products
- 🔒 **TLS Support** - Secure connections with custom certificates
- 🤖 **MCP Tools** - Built-in MCP tools for LLM integration (customer order & payment history)

## Quick Start

```bash
# Install dependencies
npm install

# Start StepZen server locally
make start
```

The API will be available at `http://localhost:5001/classic-models/v1`

## Documentation

- **[Getting Started](docs/getting-started.md)** - Setup and installation guide
- **[Sample Queries](docs/sample-queries.md)** - Example queries for common use cases
- **[API Reference](docs/api-reference.md)** - Complete query documentation
- **[Schema Reference](docs/schema.md)** - GraphQL schema types and fields
- **[Authentication](docs/authentication.md)** - Authentication setup and usage
- **[Deployment](docs/deployment.md)** - Deploying to StepZen
- **[MCP Tools](docs/mcp-tools.md)** - MCP tools for LLM integration

## Project Structure

```
├── auth.graphql          # Authentication queries
├── customers.graphql     # Customer, order, and payment types
├── productlines.graphql  # Product line and product types
├── index.graphql         # Schema entry point
├── config.yaml           # StepZen configuration
├── stepzen.config.json   # StepZen project config
└── docs/                 # Documentation
```

## License

MIT
