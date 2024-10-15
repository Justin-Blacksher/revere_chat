Secure Messanger notes

libraries I might need for GO

go-libtor
crypto/tls
golang.org/x/crypto/openpgp
github.com/go-gi/glfw
crypto/aes
golang.org/x/net/proxy


TLS
---
TLS_AES_256_GCM_SHA384

openssl req -new -newkey rsa:2048 -keyout ca.key -x509 -sha256 -days 365 -out ca.crt

New-SelfSignedCertificate -DnsName @("mywebsite.com", "www.mywebsite.com") -CertStoreLocation "cert:LocalMachineMy"
wpxclgupzlnt4ivisxxrin7c5tsz7tfqr2xcgdpe4hfsr5ov7zwhn6ad.onion

https://github.com/Justin-Blacksher/Xymon-Python.git



Program Design
==============

Secure Messaging.

1. Use TLS and Self Signed Certificates
2. Utilize Private and Public Keys
3. Utilize AES encryption
4. Route traffic through Tor
5. Digitally sign messages
6. Blockchain Technology for Integrity 
7. Docker image deployment with automatic setup


