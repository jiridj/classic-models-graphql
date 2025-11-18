# API Reference

## GraphQL Schema Overview

The GraphQL API provides the following main entities based on the Classic Models REST API:

## Authentication

- `login(username, password)` - Authenticate and get JWT tokens
- `signup(...)` - Create a new user account
- `refreshToken(refresh)` - Refresh access token
- `logout(refresh)` - Logout and invalidate refresh token
- `me` - Get current authenticated user information

## Products

- `products` - List all products
- `product(productcode)` - Get a single product by code
- `productLines` - List all product lines
- `productLine(productline)` - Get a single product line
- Mutations: `createProduct`, `updateProduct`, `deleteProduct`, `createProductLine`, `updateProductLine`, `deleteProductLine`

## Customers

- `customers` - List all customers
- `customer(customernumber)` - Get a single customer by number
- Mutations: `createCustomer`, `updateCustomer`, `deleteCustomer`

## Orders

- `orders` - List all orders
- `order(ordernumber)` - Get a single order by number
- Mutations: `createOrder`, `updateOrder`, `deleteOrder`

## Order Details

- `orderDetails` - List all order details
- `orderDetail(ordernumber, productcode)` - Get a specific order detail
- Mutations: `createOrderDetail`, `updateOrderDetail`, `deleteOrderDetail`

## Employees

- `employees` - List all employees
- `employee(employeenumber)` - Get a single employee by number
- Mutations: `createEmployee`, `updateEmployee`, `deleteEmployee`

## Offices

- `offices` - List all offices
- `office(officecode)` - Get a single office by code
- Mutations: `createOffice`, `updateOffice`, `deleteOffice`

## Payments

- `payments` - List all payments
- `payment(customernumber, checknumber)` - Get a specific payment
- Mutations: `createPayment`, `updatePayment`, `deletePayment`

## API Information

The GraphQL API connects to the Classic Models REST API at:
- **Base URL**: `https://qnap-jiri.myqnapcloud.com/classic-models/api/v1`
- **Authentication**: JWT Bearer token (required for all data endpoints)
- **Demo Credentials**: 
  - Username: `demo`
  - Password: `demo123`

## Field Names

The API uses lowercase field names (e.g., `productcode`, `customernumber`). The GraphQL schema matches the REST API response structure exactly.

