# Teleport
Teleport provides connectivity, authentication, access controls and audit for infrastructure.

[GitHub Page](https://github.com/gravitational/teleport)

# Notes
1. Create folder to store teleport configuration file and copy content from teleport.yaml
```
# Create folder
sudo mkdir -p /usr/share/teleport/config

# Create teleport.yaml
sudo vi /usr/share/teleport/config/teleport.yaml

```
2. Don't forget to replace $DOMAIN in config/teleport.yaml manually!!
3. If running teleport agent inside docker, you need to create an token 
3. Create your first user via 'tctl users add USERNAME --roles=editor,access' inside the teleport container
4. Create alias for easy usage --> alias t="docker exec -it teleport tctl"