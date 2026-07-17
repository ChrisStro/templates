# OpenZiti Admin Console

OpenZiti is a platform for building secure, zero-trust connectivity into any application or network. Every connection is authenticated with cryptographic identity, authorized by policy, and encrypted end-to-end.

[GitHub Page](https://github.com/openziti)

## Notes
- split ports for edge-management, so you can define diffirent fw rules

```
# /var/lib/ziti-controller/config.yml
web:
  # 1. Öffentlicher Port für Router und Laptops
  - name: public-endpoints
    bindPoints:
      - interface: 0.0.0.0:6262
        address: ctrl1.ztrust.cc-hgn.de:6262
    apis:
      - binding: fabric
      - binding: edge-client
      # management hier gelöscht!

  # 2. Privater Port NUR für die Verwaltung (ZAC und CLI)
  - name: private-management
    bindPoints:
      - interface: 127.0.0.1:8444  # Lauscht nur lokal auf dem VPS!
        address: localhost:8444
    apis:
      - binding: edge-management
```
