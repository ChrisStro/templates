# Guacamole

Apache Guacamole (incubating) is a clientless remote desktop gateway. It supports standard protocols like VNC, RDP, and SSH. It is called clientless because no plugins or client software are required. Thanks to HTML5, once Guacamole is installed on a server, all you need to access your desktops is a web browser.

[GitHub Page](https://github.com/boschkundendienst/guacamole-docker-compose)

# Notes
Name your stack 'guacamole', else init procedure will not work.
Init database first, don't run stack before, else an empty database file will be created and the initdb script will be ignored. So run following command first:
```
docker run --rm -v guacamole_init:/var/tmp guacamole/guacamole:1.5.0 sh -c '/opt/guacamole/bin/initdb.sh --postgres > /var/tmp/initdb.sql'
```
