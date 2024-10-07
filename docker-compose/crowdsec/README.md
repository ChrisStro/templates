# CrowdSec

CrowdSec is a free, modern & collaborative behavior detection engine, coupled with a global IP reputation network. It stacks on fail2ban's philosophy but is IPV6 compatible and 60x faster (Go vs Python).

[GitHub Page](https://github.com/crowdsecurity/crowdsec)

Notes:
- after first start create local api token for crowdsec bouncer via 'docker exec crowdsec cscli bouncers add traefik-bouncer'
- you can bann yourself for testing via 'docker exec crowdsec cscli decision add --ip YOUR.PUBLIC.IP.v4'
- Create alias for easy usage via 'alias cscli="docker exec crowdsec cscli"'
- Check decisions make: cscli decision list
- Unban yourself via cscli decision delete --ip YOUR.PUBLIC.IP.v4