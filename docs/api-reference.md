# API Reference

Complete reference for all available GraphQL queries in the Classic Models API.

## Authentication

### `_login`
Perform login and return authentication token.

```graphql
query {
  _login
}
```

**Returns:** JSON object with authentication token (`access`, `refresh`, `user`)

**Note:** This is automatically handled by the `@inject` directive. You typically don't need to call this directly.

### `_inject_token`
Inject login JSON into downstream queries (used automatically by `@inject` directive).

```graphql
query {
  _inject_token
}
```

**Returns:** JSON object with token for injection

## Customers

### `_customers`
Get all customers.

```graphql
query {
  _customers {
    customernumber
    customername
    contactfirstname
    contactlastname
    phone
    city
    country
  }
}
```

**Returns:** Array of `Customer` objects

### `_customer(id: Int!)`
Get a single customer by ID.

**Arguments:**
- `id: Int!` - Customer number

```graphql
query {
  _customer(id: 103) {
    customernumber
    customername
    orders {
      ordernumber
      orderdate
    }
    payments {
      checknumber
      amount
    }
  }
}
```

**Returns:** `Customer` object with nested orders and payments

### `_customerOrders(customerId: Int!)`
Get all orders for a specific customer.

**Arguments:**
- `customerId: Int!` - Customer number

```graphql
query {
  _customerOrders(customerId: 103) {
    ordernumber
    orderdate
    status
    orderdetails {
      productcode
      quantityordered
    }
  }
}
```

**Returns:** Array of `Order` objects

### `_customerPayments(customerId: Int!)`
Get all payments for a specific customer.

**Arguments:**
- `customerId: Int!` - Customer number

```graphql
query {
  _customerPayments(customerId: 103) {
    checknumber
    paymentdate
    amount
  }
}
```

**Returns:** Array of `Payment` objects

## Orders

### `_orderDetails(orderNumber: Int!)`
Get order details for a specific order.

**Arguments:**
- `orderNumber: Int!` - Order number

```graphql
query {
  _orderDetails(orderNumber: 10123) {
    productcode
    quantityordered
    priceeach
    orderlinenumber
  }
}
```

**Returns:** Array of `OrderDetail` objects

## Product Lines

### `_productLines`
Get all product lines.

```graphql
query {
  _productLines {
    productline
    textdescription
    products {
      productcode
      productname
    }
  }
}
```

**Returns:** Array of `ProductLine` objects

### `_productLine(productLine: String!)`
Get a single product line by name.

**Arguments:**
- `productLine: String!` - Product line name (e.g., "Classic Cars")

```graphql
query {
  _productLine(productLine: "Classic Cars") {
    productline
    textdescription
    products {
      productcode
      productname
      quantityinstock
      buyprice
      msrp
    }
  }
}
```

**Returns:** `ProductLine` object with nested products

### `_productLineProducts(productLine: String!)`
Get all products for a specific product line.

**Arguments:**
- `productLine: String!` - Product line name

```graphql
query {
  _productLineProducts(productLine: "Classic Cars") {
    productcode
    productname
    productscale
    quantityinstock
    buyprice
    msrp
  }
}
```

**Returns:** Array of `Product` objects

## Nested Fields

The following fields are available on types and provide nested data:

### Customer Fields
- `orders: [Order]` - All orders for the customer (via `@materializer`)
- `payments: [Payment]` - All payments for the customer (via `@materializer`)

### Order Fields
- `orderdetails: [OrderDetail]` - All order details for the order (via `@materializer`)

### ProductLine Fields
- `products: [Product]` - All products in the product line (via `@materializer`)

## Query Variables

All queries support GraphQL variables for dynamic values:

```graphql
query GetCustomer($id: Int!) {
  _customer(id: $id) {
    customernumber
    customername
  }
}
```

**Variables:**
```json
{
  "id": 103
}
```

## Error Handling

The API may return errors in the following format:

```json
{
  "errors": [
    {
      "message": "Error description",
      "locations": [{"line": 2, "column": 3}],
      "path": ["_customer"]
    }
  ]
}
```

Common errors:
- **Authentication errors**: Check token injection and credentials
- **Not Found**: Invalid ID or resource doesn't exist
- **Validation errors**: Invalid arguments or query structure
- **Rate Limiting**: Too many requests - wait and retry

See [Troubleshooting](../README.md#troubleshooting) for more help.

