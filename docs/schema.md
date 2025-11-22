# Schema Reference

Complete GraphQL schema types and fields for the Classic Models API.

## Types

### Customer

Represents a customer in the Classic Models database.

```graphql
type Customer {
  customernumber: Int!
  customername: String!
  contactlastname: String
  contactfirstname: String
  phone: String
  addressline1: String
  addressline2: String
  city: String
  state: String
  postalcode: String
  country: String
  salesrepemployeenumber: Int
  creditlimit: String
  orders: [Order]
  payments: [Payment]
}
```

**Fields:**
- `customernumber` (Int!, required) - Unique customer identifier
- `customername` (String!, required) - Customer name
- `contactfirstname` (String) - Contact first name
- `contactlastname` (String) - Contact last name
- `phone` (String) - Phone number
- `addressline1` (String) - Primary address line
- `addressline2` (String) - Secondary address line
- `city` (String) - City
- `state` (String) - State/province
- `postalcode` (String) - Postal/ZIP code
- `country` (String) - Country
- `salesrepemployeenumber` (Int) - Sales representative employee number
- `creditlimit` (String) - Credit limit
- `orders` ([Order]) - All orders for this customer (nested via `@materializer`)
- `payments` ([Payment]) - All payments for this customer (nested via `@materializer`)

### Order

Represents an order placed by a customer.

```graphql
type Order {
  ordernumber: Int!
  orderdate: String!
  requireddate: String!
  shippeddate: String
  status: String!
  comments: String
  customernumber: Int!
  orderdetails: [OrderDetail]
}
```

**Fields:**
- `ordernumber` (Int!, required) - Unique order identifier
- `orderdate` (String!, required) - Order date (ISO format)
- `requireddate` (String!, required) - Required delivery date
- `shippeddate` (String) - Actual shipping date
- `status` (String!, required) - Order status
- `comments` (String) - Order comments
- `customernumber` (Int!, required) - Customer who placed the order
- `orderdetails` ([OrderDetail]) - Order line items (nested via `@materializer`)

### OrderDetail

Represents a line item in an order.

```graphql
type OrderDetail {
  ordernumber: Int!
  productcode: String!
  quantityordered: Int!
  priceeach: String!
  orderlinenumber: Int!
}
```

**Fields:**
- `ordernumber` (Int!, required) - Order this detail belongs to
- `productcode` (String!, required) - Product code
- `quantityordered` (Int!, required) - Quantity ordered
- `priceeach` (String!, required) - Price per unit
- `orderlinenumber` (Int!, required) - Line number in the order

### Payment

Represents a payment made by a customer.

```graphql
type Payment {
  customernumber: Int!
  checknumber: String!
  paymentdate: String!
  amount: String!
}
```

**Fields:**
- `customernumber` (Int!, required) - Customer who made the payment
- `checknumber` (String!, required) - Check/payment number
- `paymentdate` (String!, required) - Payment date (ISO format)
- `amount` (String!, required) - Payment amount

### ProductLine

Represents a product line category.

```graphql
type ProductLine {
  productline: String!
  textdescription: String
  htmldescription: String
  image: String
  products: [Product]
}
```

**Fields:**
- `productline` (String!, required) - Product line name/identifier
- `textdescription` (String) - Text description
- `htmldescription` (String) - HTML description
- `image` (String) - Image URL or path
- `products` ([Product]) - Products in this line (nested via `@materializer`)

### Product

Represents a product in the catalog.

```graphql
type Product {
  productcode: String!
  productname: String!
  productline: String!
  productscale: String
  productvendor: String
  productdescription: String
  quantityinstock: Int
  buyprice: String
  msrp: String
}
```

**Fields:**
- `productcode` (String!, required) - Unique product code
- `productname` (String!, required) - Product name
- `productline` (String!, required) - Product line this belongs to
- `productscale` (String) - Product scale
- `productvendor` (String) - Vendor name
- `productdescription` (String) - Product description
- `quantityinstock` (Int) - Quantity in stock
- `buyprice` (String) - Buy price
- `msrp` (String) - Manufacturer's suggested retail price

## Query Type

All queries are available on the `Query` type:

```graphql
type Query {
  # Authentication
  _login: JSON
  _inject_token: JSON
  
  # Customers
  _customers: [Customer]
  _customer(id: Int!): Customer
  _customerOrders(customerId: Int!): [Order]
  _customerPayments(customerId: Int!): [Payment]
  
  # Orders
  _orderDetails(orderNumber: Int!): [OrderDetail]
  
  # Product Lines
  _productLines: [ProductLine]
  _productLine(productLine: String!): ProductLine
  _productLineProducts(productLine: String!): [Product]
}
```

## Nested Relationships

The schema supports nested queries through `@materializer` directives:

- **Customer → Orders**: Query a customer and include their orders
- **Customer → Payments**: Query a customer and include their payments
- **Order → Order Details**: Query an order and include its line items
- **ProductLine → Products**: Query a product line and include its products

## Type Relationships

```
Customer
  ├── orders: [Order]
  │     └── orderdetails: [OrderDetail]
  └── payments: [Payment]

ProductLine
  └── products: [Product]
```

## Field Notes

- Fields marked with `!` are required (non-nullable)
- String fields without `!` can be `null`
- Int fields without `!` can be `null`
- Date fields are returned as ISO 8601 strings
- Money amounts are returned as strings

