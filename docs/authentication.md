# Authentication

The Classic Models GraphQL API uses token-based authentication through the underlying REST API.

## How It Works

1. **Login Query** (`_login`) - Authenticates with the REST API and retrieves a token
2. **Token Injection** (`_inject_token`) - Automatically injects the token into downstream queries via `@inject` directive
3. **Protected Queries** - All customer, order, and product queries require authentication

## Automatic Token Injection

The API uses StepZen's `@inject` directive to automatically inject authentication tokens into protected queries. When you execute a query, StepZen will:

1. Automatically call `_inject_token` (which calls `_login`)
2. Extract the access token from the login response
3. Inject it into the `Authorization: Bearer $access` header for protected queries

## Using Authentication in Queries

### Automatic Injection (Standard)

For all queries, authentication is handled automatically - you don't need to do anything special:

```graphql
query {
  _customer(id: 103) {
    customernumber
    customername
  }
}
```

The token will be automatically fetched and injected by the `@inject` directive.

### Manual Token Check (Optional)

If you want to verify the token is being fetched, you can explicitly include `_inject_token` in your query:

```graphql
query {
  _inject_token
  _customer(id: 103) {
    customernumber
    customername
  }
}
```

**Note:** This is usually not necessary and may cause rate limiting if done frequently.

## Protected Queries

The following queries require authentication (automatically handled):

- `_customers` - Get all customers
- `_customer(id: Int!)` - Get customer by ID
- `_customerOrders(customerId: Int!)` - Get customer orders
- `_customerPayments(customerId: Int!)` - Get customer payments
- `_orderDetails(orderNumber: Int!)` - Get order details
- `_productLines` - Get all product lines
- `_productLine(productLine: String!)` - Get product line
- `_productLineProducts(productLine: String!)` - Get products for product line

## Configuration

### Credentials

Username and password are hardcoded in `auth.graphql`:
- Username: `demo`
- Password: `demo123`

No environment variables needed for REST API authentication.

### TLS Certificate

The TLS certificate is automatically loaded from `certs/ca.pem` by the Makefile. Ensure this file exists before starting the server.

## Token Details

The login endpoint returns:
- `access` - JWT access token (used for authentication)
- `refresh` - JWT refresh token
- `user` - User information

The `access` token is automatically extracted and used in the `Authorization` header for all protected queries.

## Rate Limiting

If you see "Too Many Requests" errors, this indicates:
- The login endpoint is being called too frequently
- Wait a few minutes for the rate limit to reset
- The `@inject` directive should cache tokens per request, but multiple requests may trigger rate limits

## Troubleshooting

### Error: "Unauthorized" or "variable missing: access"

- Ensure the StepZen server has been restarted after schema changes
- Check that `certs/ca.pem` exists and is valid
- Verify the `@inject` directive is properly configured in `auth.graphql`

### Error: "Too Many Requests"

- Wait 2-5 minutes for the rate limit to reset
- Avoid explicitly calling `_inject_token` in every query
- Let the `@inject` directive handle authentication automatically

See [Sample Queries](sample-queries.md) for working examples.

