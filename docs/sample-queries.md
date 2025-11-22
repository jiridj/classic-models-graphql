# Sample Queries

Ready-to-use GraphQL query examples for the Classic Models API.

## Authentication

### Login
```graphql
query {
  _login
}
```

## Customers

### Get All Customers
```graphql
query {
  _customers {
    customernumber
    customername
    contactfirstname
    contactlastname
    city
    country
  }
}
```

### Get Customer by ID
```graphql
query {
  _customer(id: 103) {
    customernumber
    customername
    phone
    city
    country
  }
}
```

### Get Customer with Orders
```graphql
query {
  _customer(id: 103) {
    customernumber
    customername
    orders {
      ordernumber
      orderdate
      status
    }
  }
}
```

### Get Customer with Orders and Order Details
```graphql
query {
  _customer(id: 103) {
    customernumber
    customername
    orders {
      ordernumber
      orderdate
      status
      orderdetails {
        productcode
        quantityordered
        priceeach
      }
    }
  }
}
```

### Get Customer with Payments
```graphql
query {
  _customer(id: 103) {
    customernumber
    customername
    payments {
      checknumber
      paymentdate
      amount
    }
  }
}
```

### Complete Customer Query (Orders + Payments + Details)
```graphql
query {
  _customer(id: 103) {
    customernumber
    customername
    contactfirstname
    contactlastname
    phone
    city
    country
    orders {
      ordernumber
      orderdate
      requireddate
      shippeddate
      status
      comments
      orderdetails {
        orderlinenumber
        productcode
        quantityordered
        priceeach
      }
    }
    payments {
      checknumber
      paymentdate
      amount
    }
  }
}
```

## Orders

### Get Customer Orders
```graphql
query {
  _customerOrders(customerId: 103) {
    ordernumber
    orderdate
    requireddate
    shippeddate
    status
    comments
  }
}
```

### Get Customer Orders with Details
```graphql
query {
  _customerOrders(customerId: 103) {
    ordernumber
    orderdate
    status
    orderdetails {
      orderlinenumber
      productcode
      quantityordered
      priceeach
    }
  }
}
```

### Get Order Details
```graphql
query {
  _orderDetails(orderNumber: 10123) {
    ordernumber
    productcode
    quantityordered
    priceeach
    orderlinenumber
  }
}
```

## Payments

### Get Customer Payments
```graphql
query {
  _customerPayments(customerId: 103) {
    customernumber
    checknumber
    paymentdate
    amount
  }
}
```

## Product Lines

### Get All Product Lines
```graphql
query {
  _productLines {
    productline
    textdescription
    htmldescription
  }
}
```

### Get Product Line by Name
```graphql
query {
  _productLine(productLine: "Classic Cars") {
    productline
    textdescription
    htmldescription
  }
}
```

### Get Product Line with Products
```graphql
query {
  _productLine(productLine: "Classic Cars") {
    productline
    textdescription
    products {
      productcode
      productname
      productscale
      productvendor
      quantityinstock
      buyprice
      msrp
    }
  }
}
```

### Get Products for Product Line
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

### Get All Product Lines with Products
```graphql
query {
  _productLines {
    productline
    textdescription
    products {
      productcode
      productname
      productscale
      quantityinstock
      buyprice
      msrp
    }
  }
}
```

## Using Variables

All queries support GraphQL variables for dynamic values:

```graphql
query GetCustomer($id: Int!) {
  _customer(id: $id) {
    customernumber
    customername
  }
}
```

**Variables (JSON):**
```json
{
  "id": 103
}
```

## Multiple Queries

You can execute multiple queries in a single request:

```graphql
query {
  customer: _customer(id: 103) {
    customernumber
    customername
  }
  orders: _customerOrders(customerId: 103) {
    ordernumber
    orderdate
  }
  payments: _customerPayments(customerId: 103) {
    checknumber
    amount
  }
}
```

## Testing

You can test these queries:
- In the GraphQL playground at `http://localhost:5001/classic-models/v1`
- Using the [Postman collection](../Classic-Models-GraphQL.postman_collection.json)
- In your GraphQL client application

