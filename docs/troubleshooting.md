# Troubleshooting Guide

## TLS Certificate Errors

If you see errors like "certificate signed by unknown authority" or "x509: certificate signed by unknown authority", this usually means:

- **Incomplete Certificate Chain**: Your server is not sending the full certificate chain (server + intermediate certificates)
- This is a common issue with Let's Encrypt certificates on QNAP

### Solution (Already Configured)

- The project includes a complete certificate chain in `certs/ca.pem`
- This file contains both the server certificate and the Let's Encrypt R13 intermediate certificate
- The certificates are automatically configured in `config.yaml` using `ca: STEPZEN_CLASSIC_MODELS_CA`
- If you still see TLS errors, verify the certificate file exists: `ls -lh certs/ca.pem`
- Check the certificate chain: `openssl crl2pkcs7 -nocrl -certfile certs/ca.pem | openssl pkcs7 -print_certs -noout`

### If You Need to Update Certificates

- See `certs/README.md` for detailed instructions on downloading and updating certificates
- The certificate chain can be downloaded using: `openssl s_client -connect qnap-jiri.myqnapcloud.com:443 -showcerts`
- The intermediate certificate can be downloaded from: `http://r13.i.lencr.org/`

### Alternative Solutions

- Use a reverse proxy (like nginx) in front of your QNAP that properly serves the full certificate chain
- Use Cloudflare for SSL termination (they handle certificate chains properly)

## Connection Issues

The base URL is hardcoded in the GraphQL schema files. Make sure the API is accessible at `https://qnap-jiri.myqnapcloud.com`

## Authentication Errors

- **At Runtime**: Include the JWT token in the `Authorization: Bearer <token>` header of your GraphQL requests
- Make sure you've logged in and obtained a JWT token using the `login` mutation
- Store tokens securely on the client side
- If you get `UNAUTHENTICATED` errors, the token may have expired - use the `refreshToken` mutation to get a new access token
- **For Development/Testing Only**: You can set `JWT_TOKEN` as an environment variable, but this is not recommended for production

## Schema Errors

Run `stepzen validate` to check for schema errors:

```bash
make validate
```

Or directly:
```bash
stepzen validate .
```

## 401 Unauthorized

This usually means your JWT token is missing, expired, or invalid. Try logging in again using the `login` mutation.

## Endpoint Mismatches

The endpoints match the OpenAPI schema at `https://qnap-jiri.myqnapcloud.com/classic-models/api/schema/`

## POST Body Issues

- If you see query parameters in error messages instead of POST body data, this has been fixed
- All mutations now use the `postbody` directive with properly formatted JSON
- Example: `postbody: "{\"username\": \"$username\", \"password\": \"$password\"}"`
- The `contenttype: "application/json"` directive ensures the body is sent as JSON

