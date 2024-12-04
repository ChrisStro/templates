# Teleport
Teleport provides connectivity, authentication, access controls and audit for infrastructure.

[GitHub Page](https://github.com/gravitational/teleport)

# Notes
1. Update teleport config in compose.yml if needed
```
configs:
  teleport.yaml:
    content: |
      # Config goes here
```
2. If running teleport agent inside docker, you need to create an token
3. Create your first user
```
docker compose exec teleport tctl users add USERNAME --roles=editor,access
```
4. Create alias for easy usage --> alias t="docker exec -it teleport tctl"