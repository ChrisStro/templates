# Docspell

Docspell is a personal document organizer. Or sometimes called a "Document Management System" (DMS). You'll need a scanner to convert your papers into files. Docspell can then assist in organizing the resulting mess 😉. It can unify your files from scanners, emails and other sources. It is targeted for home use, i.e. families, households and also for smaller groups/companies.

[GitHub Page](https://github.com/eikek/docspell)

## Notes
### Modified version of https://github.com/eikek/docspell/tree/master/kubernetes
- added init-container to solve solr permission error with volumeMounts
- added subpath volumeMount for postgres container
- modify ingress for traefik
- added oidc configuration as overlay
- added oidc with hostpath as overlay for my truenas deployments ( make sure directory exists )
- added commented region config with file-system data-store
- added network-policy manifest