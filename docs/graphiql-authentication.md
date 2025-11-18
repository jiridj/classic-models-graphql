# Using GraphiQL with Authentication

StepZen provides a built-in GraphiQL interface for testing your GraphQL API. Here's how to use it with JWT authentication.

## Accessing GraphiQL

When you run `make start` or `stepzen start`, StepZen launches a GraphiQL interface at:

```
http://localhost:5001
```

## Authentication Workflow

### Step 1: Login to Get a Token

First, use the `login` mutation in GraphiQL to get your access token:

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

Copy the `access` token from the response.

### Step 2: Add Authorization Header

In GraphiQL, you can add custom headers in the bottom panel:

1. **Look for the "Headers" or "HTTP Headers" section** at the bottom of the GraphiQL interface
2. **Click to expand** the headers panel (it may be collapsed by default)
3. **Add a new header**:
   - **Key**: `Authorization`
   - **Value**: `Bearer YOUR_ACCESS_TOKEN_HERE`
   
   Replace `YOUR_ACCESS_TOKEN_HERE` with the access token you got from the login mutation.

### Step 3: Make Authenticated Requests

Now you can run authenticated queries and mutations. For example:

```graphql
query {
  products {
    productname
    productline
    quantityinstock
  }
}
```

Or:

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

## Alternative: Using Query Variables Panel

Some GraphiQL interfaces have a "Query Variables" panel. If your interface supports it, you can also set headers there in JSON format:

```json
{
  "Authorization": "Bearer YOUR_ACCESS_TOKEN_HERE"
}
```

## Handling Token Expiration

If your token expires:

1. Use the `refreshToken` mutation to get a new access token:
   ```graphql
   mutation {
     refreshToken(refresh: "YOUR_REFRESH_TOKEN") {
       access
       refresh
     }
   }
   ```

2. Update the Authorization header with the new `access` token

3. Continue making requests

## Tips

- **Save your token**: Copy the access token to a text editor temporarily so you can easily paste it into the header
- **Token expiration**: Access tokens typically expire after a set time (check your JWT token's `exp` claim). When you get authentication errors, refresh your token
- **Headers persist**: Once you set the Authorization header in GraphiQL, it should persist for that session
- **Multiple headers**: You can add multiple headers if needed (e.g., both Authorization and custom headers)

## Troubleshooting

**Can't find the headers panel?**
- Look for a "Headers", "HTTP Headers", or "Request Headers" section
- It's usually at the bottom of the GraphiQL interface
- Some interfaces have it in a settings/gear icon menu

**Getting 401 Unauthorized errors?**
- Verify the Authorization header is set correctly: `Bearer <token>` (with a space between "Bearer" and the token)
- Check if your token has expired - try refreshing it
- Make sure you copied the entire token (they can be long)

**Token not working?**
- Ensure you're using the `access` token, not the `refresh` token
- Verify the token format: it should start with `eyJ` (base64 encoded JWT)
- Try logging in again to get a fresh token

