Generate Certificates

1) Generate a CA certificate

`openssl genrsa -out CANameHere.key -des3 2048`

we will generate a root CA using the key, that will be valid for ten years in our case

`openssl req -x509 -sha256 -new -nodes -days 3650 -key CANameHere.key -out CANameHere.pem`

2) Generate a certificate

`mkdir NameHere`

`cd NameHere`

`touch NameHere.ext`

`nano NameHere.ext`

 template of .ext file:
 
```bash
authorityKeyIdentifier = keyid,issuer

basicConstraints = CA:FALSE

keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment

subjectAltName = @alt_names

[alt_names]

DNS.1 = NameHere

IP.1 = 192.168.1.100
```

3) 

`openssl genrsa -out NameHere.key -des3 2048`

`openssl req -new -key NameHere.key -out NameHere.csr`

`openssl x509 -req -in NameHere.csr -CA ../CANameHere.pem -CAkey ../CANameHere.key -CAcreateserial -days 3650 -sha256 -extfile NameHere.ext -out NameHere.crt`

`openssl rsa -in NameHere.key -out NameHere.decrypted.key`

add both the CA certificate and the site certificate to the MMC

To import it:


Private key: NameHere.decrypted.key

Certificate: NameHere.crt

Intermediate certificate: CANameHere.pem
