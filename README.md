# Classic Models GraphQL API with IBM API Connect for GraphQL

This project creates a GraphQL API using IBM API Connect for GraphQL (formerly StepZen) that sits in front of the Classic Models REST API.

## Prerequisites

1. **IBM API Connect for GraphQL Account**: Sign up for IBM API Connect for GraphQL and obtain your domain and instance ID
2. **StepZen CLI**: Install the StepZen CLI (the CLI package name remains the same)
   ```bash
   npm install -g stepzen@latest
   ```
3. **Classic Models REST API**: You need access to your Classic Models REST API endpoint

## Setup

1. **Install dependencies**:
   ```bash
   npm install
   ```

2. **Login to IBM API Connect for GraphQL**:
   
   **Option A: Using the login script (Recommended)**
   
   Create a `.env` file in the root directory with your StepZen credentials:
   ```env
   STEPZEN_DOMAIN=a-vir-s1.apicgql.ipaas.ibmappdomain.cloud
   STEPZEN_INSTANCE_ID=20250617-1018-3208-90a6-b4987b85b1f7
   STEPZEN_API_KEY=your_api_key_here
   STEPZEN_INTROSPECTION=introspection.a-vir-s1.apicgql.ipaas.ibmappdomain.cloud
   ```
   
   Then run the login script:
   ```bash
   ./login.sh
   ```
   
   **Option B: Manual login**
   
   ```bash
   stepzen login <domain> -i <instance_id> -k <api_key> --introspection <introspection_url>
   ```
   
   Replace the placeholders with your specific IBM API Connect for GraphQL credentials.

3. **Configure JWT Authentication**:
   
   The API uses JWT authentication. You need to obtain a JWT token by logging in first:
   
   ```bash
   # Login to get JWT token
   curl -X POST https://qnap-jiri.myqnapcloud.com/classic-models/api/auth/login/ \
     -H "Content-Type: application/json" \
     -d '{"username": "demo", "password": "demo123"}'
   ```
   
   Then set the JWT token as an environment variable:
   ```bash
   export JWT_TOKEN=your_jwt_token_here
   ```
   
   Or create a `.env` file:
   ```env
   JWT_TOKEN=your_jwt_token_here
   ```

4. **Start the GraphQL server locally**:
   ```bash
   npm run stepzen:start
   ```
   
   Or directly:
   ```bash
   stepzen start
   ```
   
   This command starts a local server where you can test your GraphQL API.

5. **Deploy to IBM API Connect for GraphQL**:
   ```bash
   npm run stepzen:deploy
   ```
   
   Or directly:
   ```bash
   stepzen deploy
   ```
   
   This command deploys your GraphQL API to your IBM API Connect for GraphQL environment, making it accessible to your applications.

## Project Structure

```
.
├── config.yaml              # IBM API Connect for GraphQL configuration
├── index.graphql            # Main schema file that imports all schemas
├── products.graphql         # Product and ProductLine types, queries, and mutations
├── customers.graphql        # Customer types, queries, and mutations
├── orders.graphql           # Order types, queries, and mutations
├── employees.graphql        # Employee types, queries, and mutations
├── offices.graphql          # Office types, queries, and mutations
├── payments.graphql         # Payment types, queries, and mutations
├── orderdetails.graphql     # OrderDetail types, queries, and mutations
├── auth.graphql             # Authentication queries and mutations
├── login.sh                 # Script to login to StepZen using .env variables
├── .env.example             # Example environment variables file
├── package.json            # Node.js dependencies
└── README.md               # This file
```

## GraphQL Schema

The GraphQL API provides the following main entities based on the Classic Models REST API:

### Authentication
- `login(username, password)` - Authenticate and get JWT tokens
- `signup(...)` - Create a new user account
- `refreshToken(refresh)` - Refresh access token
- `logout(refresh)` - Logout and invalidate refresh token
- `me` - Get current authenticated user information

### Products
- `products` - List all products
- `product(productcode)` - Get a single product by code
- `productLines` - List all product lines
- `productLine(productline)` - Get a single product line
- Mutations: `createProduct`, `updateProduct`, `deleteProduct`, `createProductLine`, `updateProductLine`, `deleteProductLine`

### Customers
- `customers` - List all customers
- `customer(customernumber)` - Get a single customer by number
- Mutations: `createCustomer`, `updateCustomer`, `deleteCustomer`

### Orders
- `orders` - List all orders
- `order(ordernumber)` - Get a single order by number
- Mutations: `createOrder`, `updateOrder`, `deleteOrder`

### Order Details
- `orderDetails` - List all order details
- `orderDetail(ordernumber, productcode)` - Get a specific order detail
- Mutations: `createOrderDetail`, `updateOrderDetail`, `deleteOrderDetail`

### Employees
- `employees` - List all employees
- `employee(employeenumber)` - Get a single employee by number
- Mutations: `createEmployee`, `updateEmployee`, `deleteEmployee`

### Offices
- `offices` - List all offices
- `office(officecode)` - Get a single office by code
- Mutations: `createOffice`, `updateOffice`, `deleteOffice`

### Payments
- `payments` - List all payments
- `payment(customernumber, checknumber)` - Get a specific payment
- Mutations: `createPayment`, `updatePayment`, `deletePayment`

## Example Queries

### Login to get JWT token:
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

### Get a product with details:
```graphql
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

### Get a customer:
```graphql
query {
  customer(customernumber: 103) {
    customername
    city
    country
    creditlimit
  }
}
```

### Get an order:
```graphql
query {
  order(ordernumber: 10100) {
    ordernumber
    orderdate
    status
    customernumber
  }
}
```

### Get order details for an order:
```graphql
query {
  orderDetail(ordernumber: 10100, productcode: "S10_1678") {
    id
    quantityordered
    priceeach
    orderlinenumber
  }
}
```

### Get current user:
```graphql
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

## API Information

The GraphQL API connects to the Classic Models REST API at:
- **Base URL**: `https://qnap-jiri.myqnapcloud.com/classic-models/api/v1`
- **Authentication**: JWT Bearer token (required for all data endpoints)
- **Demo Credentials**: 
  - Username: `demo`
  - Password: `demo123`

## Customization

### Adjusting REST API Endpoints

The API endpoints are configured in `config.yaml` and in each `.graphql` file. The base URL is set in `config.yaml`, and individual endpoints are specified in the `@rest` directives.

### Authentication

JWT authentication is configured in `config.yaml`. You need to:
1. Login using the `login` mutation to get an access token
2. Set the `JWT_TOKEN` environment variable with the access token
3. The token will be automatically included in all API requests

### Field Names

The API uses lowercase field names (e.g., `productcode`, `customernumber`). The GraphQL schema matches the REST API response structure exactly.

## Troubleshooting

1. **TLS Certificate Errors**: 
   - If you see errors like "certificate signed by unknown authority" or "x509: certificate signed by unknown authority", this usually means:
     - **Incomplete Certificate Chain**: Your server is not sending the full certificate chain (server + intermediate certificates)
     - This is a common issue with Let's Encrypt certificates on QNAP
   - **Solution for QNAP**:
     - In QNAP's SSL certificate settings, ensure you're using the **full certificate chain** (not just the server certificate)
     - The certificate file should include both:
       1. Your server certificate (`qnap-jiri.myqnapcloud.com`)
       2. The intermediate certificate (Let's Encrypt R13)
     - You may need to download the intermediate certificate from Let's Encrypt and combine it with your server certificate
     - Verify the chain is complete by running: `openssl s_client -connect qnap-jiri.myqnapcloud.com:443 -showcerts`
     - You should see at least 2 certificates in the chain (server + intermediate)
   - **Alternative Solutions**:
     - Use a reverse proxy (like nginx) in front of your QNAP that properly serves the full certificate chain
     - Use Cloudflare for SSL termination (they handle certificate chains properly)
   - **Note**: StepZen requires the full certificate chain to verify certificates properly

2. **Connection Issues**: The base URL is hardcoded in the GraphQL schema files. Make sure the API is accessible at `https://qnap-jiri.myqnapcloud.com`

3. **Authentication Errors**: 
   - Make sure you've logged in and obtained a JWT token
   - Set the `JWT_TOKEN` environment variable
   - Check that the token hasn't expired (use `refreshToken` mutation to refresh)

4. **Schema Errors**: Run `stepzen validate` to check for schema errors

5. **401 Unauthorized**: This usually means your JWT token is missing, expired, or invalid. Try logging in again

6. **Endpoint Mismatches**: The endpoints match the OpenAPI schema at `https://qnap-jiri.myqnapcloud.com/classic-models/api/schema/`

7. **POST Body Issues**: If you see query parameters in error messages instead of POST body data, ensure the `postbody` directive is correctly formatted with escaped quotes

## Additional Setup Options

### Importing from OpenAPI Specification

If your Classic Models REST API has an OpenAPI Specification (OAS), you can generate a GraphQL schema from it:

```bash
stepzen import openapi <path_to_openapi_spec>
```

This command generates a GraphQL schema based on your REST API's OpenAPI Specification file.

### Importing from cURL

You can also import REST endpoints directly from cURL commands:

```bash
stepzen import curl 'https://your-api.com/endpoint'
```

## Resources

- [IBM API Connect for GraphQL Documentation](https://www.ibm.com/docs/en/api-connect)
- [StepZen CLI Documentation](https://stepzen.com/docs) (CLI documentation still uses StepZen branding)
- [GraphQL Best Practices](https://graphql.org/learn/best-practices/)

