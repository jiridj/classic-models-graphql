# Setup Guide

## Prerequisites

1. **IBM API Connect for GraphQL Account**: Sign up for IBM API Connect for GraphQL and obtain your domain and instance ID
2. **StepZen CLI**: Install the StepZen CLI (the CLI package name remains the same)
   ```bash
   npm install -g stepzen@latest
   ```
3. **Classic Models REST API**: You need access to your Classic Models REST API endpoint

## Installation Steps

### 1. Install Dependencies

```bash
npm install
```

### 2. Login to IBM API Connect for GraphQL

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

### 3. Configure TLS Certificates

The project includes TLS certificates for secure connections. The certificate chain has been automatically downloaded and configured in `certs/ca.pem`. This file contains:
- Server certificate for `qnap-jiri.myqnapcloud.com`
- Let's Encrypt R13 intermediate certificate

The certificates are configured in `config.yaml` using `ca: STEPZEN_CLASSIC_MODELS_CA` (an environment variable).

**Important**: Before starting or deploying StepZen, you must export the certificate:
```bash
export STEPZEN_CLASSIC_MODELS_CA="$(cat certs/ca.pem)"
```

Or use the Makefile commands (`make start` or `make deploy`) which handle this automatically.

If you need to update the certificates, see `certs/README.md` for instructions.

### 4. Start the GraphQL Server Locally

**Option A: Using Makefile (Recommended)**
```bash
make start
```
This automatically exports the TLS certificate and starts the server.

**Option B: Using npm**
```bash
npm run stepzen:start
```

**Option C: Directly (requires manual certificate export)**
```bash
export STEPZEN_CLASSIC_MODELS_CA="$(cat certs/ca.pem)"
stepzen start
```

This command starts a local server where you can test your GraphQL API.

### 5. Deploy to IBM API Connect for GraphQL

**Option A: Using Makefile (Recommended)**
```bash
make deploy
```
This automatically exports the TLS certificate and deploys the API.

**Option B: Using npm**
```bash
npm run stepzen:deploy
```

**Option C: Directly (requires manual certificate export)**
```bash
export STEPZEN_CLASSIC_MODELS_CA="$(cat certs/ca.pem)"
stepzen deploy
```

This command deploys your GraphQL API to your IBM API Connect for GraphQL environment, making it accessible to your applications.

## Project Structure

```
.
├── config.yaml              # IBM API Connect for GraphQL configuration (TLS, headers)
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
├── setup-tls.sh             # Script to export TLS certificate
├── Makefile                 # Makefile with common commands (start, deploy, etc.)
├── .env.example             # Example environment variables file
├── certs/                   # TLS certificates directory
│   ├── ca.pem               # Certificate chain (server + intermediate)
│   ├── server.pem           # Server certificate
│   ├── letsencrypt-r13.pem  # Let's Encrypt R13 intermediate certificate
│   └── README.md            # Certificate setup instructions
├── docs/                    # Documentation files
├── package.json            # Node.js dependencies
└── README.md               # Main documentation file
```

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

