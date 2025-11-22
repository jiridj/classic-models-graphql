# MCP Tools for LLM Integration

This GraphQL API includes MCP (Model Context Protocol) tools that allow LLMs to query customer order and payment history.

**Reference:** [StepZen @tool Directive Documentation](https://www.ibm.com/docs/en/api-connect-graphql/saas?topic=directives-directive-tool)

## Overview

When deployed to API Connect/StepZen, the GraphQL API automatically exposes MCP endpoints that LLMs can use. The `@tool` directive defines these tools as GraphQL schema subsets.

## Available MCP Tools

### 1. customer-order-history

Retrieves complete order history for a customer, including order details (products, quantities, prices).

**Tool Name:** `customer-order-history`

**Description:** Retrieve complete order history for a customer, including order details (products, quantities, prices). Returns orders with their status, dates, and line items.

**Schema Exposure:**
- Query: `_customerOrders`
- Type: `Order` (all fields including nested `orderdetails`)
- Type: `OrderDetail` (all fields)

**Usage:**
LLMs can query this tool with GraphQL requests:

```graphql
query {
  _customerOrders(customerId: 103) {
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
```

### 2. customer-payment-history

Retrieves payment history for a customer.

**Tool Name:** `customer-payment-history`

**Description:** Retrieve payment history for a customer. Returns all payments including check numbers, dates, and amounts.

**Schema Exposure:**
- Query: `_customerPayments`
- Type: `Payment` (all fields)

**Usage:**
LLMs can query this tool with GraphQL requests:

```graphql
query {
  _customerPayments(customerId: 103) {
    checknumber
    paymentdate
    amount
  }
}
```

## MCP Endpoints

When deployed to StepZen/API Connect, MCP endpoints are automatically available:

- **GraphQL Endpoint:** `https://{account}.stepzen.net/api/{folder}/{name}/graphql`
- **MCP Endpoint:** `https://{account}.stepzen.net/api/{folder}/{name}/mcp`

Example:
- GraphQL: `https://newyork.us-east-a.ibm.stepzen.net/api/classic-models/v1/graphql`
- MCP: `https://newyork.us-east-a.ibm.stepzen.net/api/classic-models/v1/mcp`

## Virtual GraphQL Endpoints

Each tool exposes a virtual GraphQL endpoint:
- Order History: `https://{account}.stepzen.net/api/{folder}/{name}/tools/customer-order-history/graphql`
- Payment History: `https://{account}.stepzen.net/api/{folder}/{name}/tools/customer-payment-history/graphql`

## Tool Definition

Tools are defined in `index.graphql` using the `@tool` directive:

```graphql
extend schema
  @tool(
    name: "customer-order-history"
    description: "Retrieve complete order history for a customer..."
    graphql: [
      { expose: true, types: "Query", fields: "_customerOrders" }
      { expose: true, types: "Order", fields: ".*" }
      { expose: true, types: "OrderDetail", fields: ".*" }
    ]
  )
```

## References

- [StepZen @tool Directive Documentation](https://www.ibm.com/docs/en/api-connect-graphql/saas?topic=directives-directive-tool)
- [MCP Specification](https://modelcontextprotocol.io/)
