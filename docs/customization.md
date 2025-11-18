# Customization Guide

## Adjusting REST API Endpoints

The API endpoints are configured in `config.yaml` and in each `.graphql` file. The base URL is set in `config.yaml`, and individual endpoints are specified in the `@rest` directives.

To change the base URL, update the endpoint URLs in each `.graphql` file. For example, in `products.graphql`:

```graphql
@rest(
  endpoint: "https://your-new-api.com/classic-models/api/v1/products/"
  configuration: "classic_models_rest"
  tls: "classic_models_rest"
)
```

## Authentication Configuration

JWT authentication is configured in `config.yaml`. The configuration references environment variables for TLS certificates.

For runtime authentication, clients should pass tokens in the Authorization header. See [Authentication Guide](./authentication.md) for details.

## Field Names

The API uses lowercase field names (e.g., `productcode`, `customernumber`). The GraphQL schema matches the REST API response structure exactly.

If you need to change field names or add custom resolvers, you can modify the GraphQL schema files directly.

## Adding New Entities

To add a new entity:

1. Create a new `.graphql` file (e.g., `newentity.graphql`)
2. Define the GraphQL types, queries, and mutations
3. Add the `@rest` directives with appropriate endpoints
4. Include the TLS configuration: `tls: "classic_models_rest"`
5. Import the file in `index.graphql`:
   ```graphql
   schema @sdl(files: [..., "newentity.graphql"]) {
     query: Query
     mutation: Mutation
   }
   ```

## Modifying Existing Queries/Mutations

To modify an existing query or mutation:

1. Open the relevant `.graphql` file
2. Update the `@rest` directive with new endpoints or parameters
3. Ensure TLS configuration is included: `tls: "classic_models_rest"` or `tls: "classic_models_auth"`
4. Validate the schema: `make validate`

## TLS Certificate Configuration

TLS certificates are configured in `config.yaml` using environment variables. See [Setup Guide](./setup.md#3-configure-tls-certificates) for details.

To update certificates:
1. Download new certificates to `certs/` directory
2. Update `certs/ca.pem` with the new certificate chain
3. Restart StepZen server

