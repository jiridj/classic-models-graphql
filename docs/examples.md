# Example Queries and Mutations

## Authentication Examples

### Login to get JWT token

```graphql
mutation {
  login(username: "demo", password: "demo123") {
    access
    refresh
    user {
      id
      username
      email
    }
  }
}
```

### Get current user (requires Authorization header)

```graphql
# Include in HTTP headers: Authorization: Bearer YOUR_ACCESS_TOKEN
query {
  me {
    id
    username
    email
    first_name
    last_name
  }
}
```

### Refresh access token

```graphql
mutation {
  refreshToken(refresh: "YOUR_REFRESH_TOKEN") {
    access
    refresh
  }
}
```

## Product Examples

### Get all products (requires Authorization header)

```bash
curl -X POST http://localhost:5001/api/classic-models/v1 \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -d '{
    "query": "query { products { productname productline quantityinstock } }"
  }'
```

### Get a specific product

```bash
curl -X POST http://localhost:5001/api/classic-models/v1 \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -d '{
    "query": "query { product(productcode: \"S10_1678\") { productname productline quantityinstock buyprice msrp } }"
  }'
```

Or using GraphQL directly:
```graphql
# Include in HTTP headers: Authorization: Bearer YOUR_ACCESS_TOKEN
query {
  product(productcode: "S10_1678") {
    productname
    productline
    quantityinstock
    buyprice
    msrp
  }
}
```

### Get product lines

```graphql
# Include in HTTP headers: Authorization: Bearer YOUR_ACCESS_TOKEN
query {
  productLines {
    productline
    textdescription
    htmldescription
  }
}
```

## Customer Examples

### Get a customer

```bash
curl -X POST http://localhost:5001/api/classic-models/v1 \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -d '{
    "query": "query { customer(customernumber: 103) { customername city country creditlimit } }"
  }'
```

## Order Examples

### Get an order

```graphql
# Include in HTTP headers: Authorization: Bearer YOUR_ACCESS_TOKEN
query {
  order(ordernumber: 10100) {
    ordernumber
    orderdate
    status
    customernumber
  }
}
```

### Get order details for an order

```graphql
# Include in HTTP headers: Authorization: Bearer YOUR_ACCESS_TOKEN
query {
  orderDetail(ordernumber: 10100, productcode: "S10_1678") {
    id
    quantityordered
    priceeach
    orderlinenumber
  }
}
```

## Mutation Examples

### Create a product

```graphql
# Include in HTTP headers: Authorization: Bearer YOUR_ACCESS_TOKEN
mutation {
  createProduct(
    productcode: "S99_9999"
    productname: "New Product"
    productline: "Classic Cars"
    productscale: "1:18"
    productvendor: "Vendor Name"
    productdescription: "Product description"
    quantityinstock: 100
    buyprice: "50.00"
    msrp: "75.00"
  ) {
    productcode
    productname
  }
}
```

### Update a customer

```graphql
# Include in HTTP headers: Authorization: Bearer YOUR_ACCESS_TOKEN
mutation {
  updateCustomer(
    customernumber: 103
    customername: "Updated Name"
    contactlastname: "Last"
    contactfirstname: "First"
    phone: "123-456-7890"
    addressline1: "123 Main St"
    city: "City"
    country: "USA"
  ) {
    customernumber
    customername
  }
}
```

