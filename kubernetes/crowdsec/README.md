# CrowdSec

CrowdSec is a free, modern & collaborative behavior detection engine, coupled with a global IP reputation network. It stacks on fail2ban's philosophy but is IPV6 compatible and 60x faster (Go vs Python).

[GitHub Page](https://github.com/crowdsecurity/crowdsec)

Notes:
- bouncer authentication via certificates (gets mirrored via reflector)
- Create alias via "alias cscli='kubectl exec -it deploy/crowdsec-lapi -- cscli'"
- you can bann yourself for testing via 'cscli decision add --ip YOUR.PUBLIC.IP.v4'
- Check decisions make: cscli decision list
- Unban yourself via cscli decision delete --ip YOUR.PUBLIC.IP.v4