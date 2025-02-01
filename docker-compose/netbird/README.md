# Netbird

NetBird combines a configuration-free peer-to-peer private network and a centralized access control system in a single platform, making it easy to create secure private networks for your organization or home.

Connect. NetBird creates a WireGuard-based overlay network that automatically connects your machines over an encrypted tunnel, leaving behind the hassle of opening ports, complex firewall rules, VPN gateways, and so forth.

[GitHub Page](https://github.com/netbirdio/netbird)

## Notes
- Use   https://$NETBIRD_DOMAIN/auth & https://$NETBIRD_DOMAIN/silent-auth as redirection url's
- Read documentation and create needed client apps https://docs.netbird.io/selfhosted/identity-providers
- We using merged compose files
```
# azure
docker compose -f compose.yml -f ./addl/oidc/azure/compose.override.yml --env-file ./addl/oidc/azure/.env up -d
```
- You can merge the env files and then move compose.override.yml the same folder as compose.yml, this way you can run simple 'docker compose up -d' command
- Update: Removed STURN and TURN config, switched to netbirds own relay server for simplicity (currently not offical support)