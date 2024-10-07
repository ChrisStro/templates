# Boundary

Boundary is an identity-aware proxy that provides a simple, secure way to access hosts and critical systems on your network.

[GitHub Page](https://github.com/hashicorp/boundary)

Notes:
- create secrets: curl https://raw.githubusercontent.com/hashicorp/boundary-reference-architecture/main/deployment/docker/compose/keygen.py 2>/dev/null |python3 -
- add secrets to env variables
- look at logs on first start for initital login
- multihop not supported in open source boundary, so every worker needs to be public reachable (that's realy annoyning)
