# OAuth2 Proxy

A reverse proxy and static file server that provides authentication using Providers (Google, Keycloak, GitHub and others) to validate accounts by email, domain or group.

[GitHub Page](https://github.com/oauth2-proxy/oauth2-proxy)

## Notes
- currently tested with Entra ID as IDP
- compose file creates middleware fwoauth
- assign fwoauth to your services via traefik labels
- OAUTH2_PROXY_REDIRECT_URL env is a static redirect(back), if using multible services you, have to comment out this env