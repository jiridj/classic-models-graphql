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
- Query: `customerOrders`
- Type: `Order` (all fields including nested `orderdetails`)
- Type: `OrderDetail` (all fields)

**Usage:**
LLMs can query this tool with GraphQL requests:

```graphql
query {
  customerOrders(customerId: 103) {
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
- Query: `customerPayments`
- Type: `Payment` (all fields)

**Usage:**
LLMs can query this tool with GraphQL requests:

```graphql
query {
  customerPayments(customerId: 103) {
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
      { expose: true, types: "Query", fields: "customerOrders" }
      { expose: true, types: "Order", fields: ".*" }
      { expose: true, types: "OrderDetail", fields: ".*" }
    ]
  )
```

## Configuring MCP Clients

To use this MCP server with an LLM client (such as Claude Desktop), you need to configure the client to connect to your deployed StepZen MCP endpoint.

### Prerequisites

1. **Deployed StepZen API**: Your GraphQL API must be deployed to StepZen
2. **MCP Endpoint URL**: Get your MCP endpoint URL after deployment (format: `https://{account}.stepzen.net/api/{folder}/{name}/mcp`)
3. **Authentication Token**: Obtain an authentication token for accessing the StepZen API

### Sample MCP Client Configuration

For **Claude Desktop** or similar MCP clients, add the following configuration to your MCP settings file (typically `~/Library/Application Support/Claude/claude_desktop_config.json` on macOS or `%APPDATA%\Claude\claude_desktop_config.json` on Windows):

```json
{
  "mcpServers": {
    "classic-models": {
      "command": "npx",
      "args": [
        "mcp-remote",
        "https://{account}.stepzen.net/api/classic-models/v1/mcp",
        "--header",
        "Authorization: Apikey ${API_KEY}"
      ],
      "env": {
        "API_KEY": "your-stepzen-api-key-here"
      }
    }
  }
}
```

### Configuration Parameters

- **`command`**: `npx` - Uses npm to run the `mcp-remote` package
- **`args`**: 
  - `mcp-remote` - The MCP remote client package
  - `https://{account}.stepzen.net/api/classic-models/v1/mcp` - Your StepZen MCP endpoint URL
  - `--header` - Specifies custom headers for authentication
  - `Authorization: Bearer ${AUTH_TOKEN}` - Authorization header template using environment variable
- **`env`**: 
  - `AUTH_TOKEN` - Your StepZen API key or authentication token

### Example Configuration

Replace the placeholders with your actual values:

### Getting Your StepZen API Key

1. Log in to your IBM API Connect for GraphQL account
2. Navigate to your SaaS instance settings
3. Generate or retrieve your API key
4. Copy the key and use it as the `API_KEY` value in your configuration

### Testing the Configuration

After configuring your MCP client:

1. Restart your LLM client application
2. Verify that the MCP server appears in your available tools
3. Test by asking the LLM to query customer order or payment history

Example queries the LLM can now perform:
- "Get order history for customer 103"
- "Show payment history for customer 450"
- "List all orders with their details for customer 144"

## References

- [StepZen @tool Directive Documentation](https://www.ibm.com/docs/en/api-connect-graphql/saas?topic=directives-directive-tool)
- [MCP Specification](https://modelcontextprotocol.io/)
- [MCP Remote Client](https://www.npmjs.com/package/mcp-remote)
