# Postman Collections for Classic Models GraphQL API

This folder contains Postman collections for testing the Classic Models GraphQL API.

## Files

- **classic-models-graphql.postman_collection.json** - Main collection with queries and mutations for the Classic Models GraphQL API
- **Local.postman_environment.json** - Environment configuration for local development

## Setup

### 1. Import Collection

1. Open Postman
2. Click **Import** button
3. Select `classic-models-graphql.postman_collection.json`
4. Click **Import**

### 2. Import Environment (Optional)

1. In Postman, click the **Environments** icon (left sidebar)
2. Click **Import**
3. Select `Local.postman_environment.json`
4. Click **Import**
5. Select the "Local" environment from the environment dropdown (top right)

### 3. Start GraphQL Server

Before running the queries, make sure your GraphQL server is running:

```bash
make start
```

The server should be accessible at `http://localhost:5001`

## Collection Structure

### Customer Order History

This collection demonstrates the `customerOrderHistory` query with various examples:

1. **Full Order History** - Complete nested query with all fields (customer, orders, order details, products)
2. **Order History - Basic Info Only** - Minimal fields to demonstrate GraphQL's field selection
3. **Order History - With Order Totals** - Includes data needed to calculate order totals
4. **Order History - Products Only** - Focuses on product information
5. **Order History - Recent Orders** - Includes date information for sorting

### Examples

Pre-configured queries for specific customers:
- Customer 103 - Atelier graphique
- Customer 112 - Signal Gift Stores
- Customer 114 - Australian Collectors

## Testing the Query

### Why This Query Demonstrates GraphQL's Value

In a REST API, fetching complete customer order history would require:

1. `GET /customers/{id}/` - Customer information
2. `GET /customers/{id}/orders/` - List of orders
3. For each order: `GET /orders/{id}/orderdetails/` - Order line items
4. For each order detail: `GET /products/{code}/` - Product information

**Total**: 1 + 1 + N + M API calls (where N = number of orders, M = number of unique products)

With GraphQL, all this data is fetched in a **single request**, and you can select exactly the fields you need.

### Example Query

```graphql
query {
  customerOrderHistory(customernumber: 103) {
    customernumber
    customername
    city
    country
    orders {
      ordernumber
      orderdate
      status
      orderdetails {
        quantityordered
        priceeach
        product {
          productname
          msrp
        }
      }
    }
  }
}
```

## Variables

The collection uses the following variables:

- `baseUrl` - GraphQL endpoint URL (default: `http://localhost:5001/api/classic-models/v1`)
- `customernumber` - Customer number for queries (default: `103`)

You can modify these in the environment or collection variables.

## Tips

1. **Start with "Full Order History"** to see all available data
2. **Compare query sizes** - Try "Basic Info Only" vs "Full Order History" to see the difference in response size
3. **Check the Tests tab** - Each request includes tests to verify the response
4. **Modify queries** - You can edit the GraphQL queries in Postman to fetch different fields

## Troubleshooting

### Server not responding

- Ensure the GraphQL server is running: `make start`
- Check that the server is accessible at the `baseUrl`
- Verify the server started successfully (check terminal output)

### Authentication errors

The `customerOrderHistory` query automatically handles authentication internally, so you don't need to provide tokens in the request.

### Empty responses

- Verify the customer number exists in the database
- Check that the customer has orders
- Review the server logs for errors

## Notes

- The `customerOrderHistory` query automatically authenticates using credentials from environment variables
- All nested relationships (orders, order details, products) are automatically resolved
- You can request any combination of fields - GraphQL will only fetch what you ask for

