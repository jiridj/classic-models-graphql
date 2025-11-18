# TLS Certificates

This directory should contain the TLS certificates needed for connecting to the QNAP server.

## Required Files

1. **ca.pem** - The CA (Certificate Authority) certificate chain
   - This should include the intermediate certificate (Let's Encrypt R13) and any root certificates
   - Can be a single file with multiple certificates concatenated, or separate files

2. **server.pem** (optional) - The server certificate for qnap-jiri.myqnapcloud.com
   - Usually not needed if the CA chain is complete, but can be included for reference

## How to Get the Certificates

### Option 1: From QNAP
1. Log into your QNAP NAS
2. Go to Control Panel > Security > SSL Certificate
3. Export the certificate and certificate chain

### Option 2: Using OpenSSL
```bash
# Get the full certificate chain
openssl s_client -connect qnap-jiri.myqnapcloud.com:443 -showcerts < /dev/null 2>/dev/null | \
  openssl x509 -outform PEM > certs/server.pem

# Get the intermediate certificate (Let's Encrypt R13)
# Download from Let's Encrypt: https://letsencrypt.org/certs/
# Or extract from the chain above
```

### Option 3: Download Let's Encrypt Intermediate Certificate
```bash
# Download Let's Encrypt R3 intermediate certificate
curl -o certs/letsencrypt-r3.pem https://letsencrypt.org/certs/lets-encrypt-r3.pem

# Or R13 if that's what your certificate uses
curl -o certs/letsencrypt-r13.pem https://letsencrypt.org/certs/lets-encrypt-r13.pem
```

## File Format

Certificates should be in PEM format (base64 encoded, with `-----BEGIN CERTIFICATE-----` and `-----END CERTIFICATE-----` markers).

If you have multiple certificates (server + intermediate), you can concatenate them:
```bash
cat server.pem intermediate.pem > ca.pem
```

