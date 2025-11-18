# Authentication Guide

## Overview

The API uses JWT authentication. **At runtime, clients should pass the JWT token in the Authorization header of each GraphQL request**, not as an environment variable.

## Client-Side Token Management Pattern

### 1. Login to Get Tokens

Use the `login` mutation to get access and refresh tokens:

```graphql
mutation {
  login(username: "demo", password: "demo123") {
    access
    refresh
    user {
      id
      username
    }
  }
}
```

### 2. Store Tokens Securely

Store tokens securely on the client:
- **In memory** (for single-page applications)
- **Secure storage** (localStorage, sessionStorage - be aware of XSS risks)
- **HttpOnly cookies** (recommended for web applications)

### 3. Include Token in Requests

Send the access token in the Authorization header of each GraphQL request:

```bash
curl -X POST http://localhost:5001/api/classic-models/v1 \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -d '{"query": "{ products { productname } }"}'
```

### 4. Handle Token Expiration

When the access token expires:
- Use the `refreshToken` mutation to get a new access token
- Update your stored tokens
- Retry the original request with the new token

## Example Client Implementation

### JavaScript/Apollo Client

```javascript
import { ApolloClient, createHttpLink, InMemoryCache, from } from '@apollo/client';
import { setContext } from '@apollo/client/link/context';
import { onError } from '@apollo/client/link/error';

// Get token from storage
const getToken = () => localStorage.getItem('accessToken');
const getRefreshToken = () => localStorage.getItem('refreshToken');

// Refresh token function
const refreshAccessToken = async () => {
  const refresh = getRefreshToken();
  if (!refresh) throw new Error('No refresh token');
  
  const response = await fetch('http://localhost:5001/api/classic-models/v1', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      query: `
        mutation {
          refreshToken(refresh: "${refresh}") {
            access
            refresh
          }
        }
      `
    })
  });
  
  const { data } = await response.json();
  localStorage.setItem('accessToken', data.refreshToken.access);
  localStorage.setItem('refreshToken', data.refreshToken.refresh);
  return data.refreshToken.access;
};

// Auth link to add token to requests
const authLink = setContext((_, { headers }) => {
  const token = getToken();
  return {
    headers: {
      ...headers,
      authorization: token ? `Bearer ${token}` : "",
    }
  };
});

// Error link to handle token expiration
const errorLink = onError(({ graphQLErrors, operation, forward }) => {
  if (graphQLErrors) {
    for (let err of graphQLErrors) {
      if (err.extensions?.code === 'UNAUTHENTICATED') {
        // Token expired, refresh and retry
        return refreshAccessToken().then(token => {
          operation.setContext({
            headers: {
              ...operation.getContext().headers,
              authorization: `Bearer ${token}`,
            }
          });
          return forward(operation);
        });
      }
    }
  }
});

const httpLink = createHttpLink({
  uri: 'http://localhost:5001/api/classic-models/v1',
});

const client = new ApolloClient({
  link: from([errorLink, authLink, httpLink]),
  cache: new InMemoryCache()
});
```

## Available Auth Mutations

- `login(username, password)` - Authenticate and get JWT tokens
- `signup(...)` - Create a new user account
- `refreshToken(refresh)` - Refresh access token
- `logout(refresh)` - Logout and invalidate refresh token
- `me` - Get current authenticated user information (requires Authorization header)

## Development/Testing Note

For development/testing, you can temporarily set `JWT_TOKEN` as an environment variable, but this is **NOT recommended for production**.

