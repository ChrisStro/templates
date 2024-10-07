# Netbootxyz

The netboot.xyz docker image allows you to easily set up a local instance of netboot.xyz. The container is a small helper application written in node.js. It provides a simple web interface for editing menus on the fly, retrieving the latest menu release of netboot.xyz, and enables mirroring the downloadable assets from Github to your location machine for faster booting of assets.

[GitHub Page](https://github.com/netbootxyz/docker-netbootxyz)

# Notes
## If you need fast DHCP-Server install

```
# Install isc-dhcp-server on debian
sudo apt install isc-dhcp-server

# edit /etc/default/isc-dhcp-server to bind interface
INTERFACESv4="eth0"

# edit /etc/dhcp/dhcpd.conf with sample config
option arch code 93 = unsigned integer 16;

subnet 192.168.3.0 netmask 255.255.255.0 {
  range 192.168.3.34 192.168.3.254;       # Change this range as appropriate for your network
  next-server 192.168.3.48;               # Change this to the address of your DHCP server !!!!!!
  option subnet-mask 255.255.255.0;
  option routers 192.168.3.1;             # Change this to the address of your router
  option broadcast-address 192.168.3.255;
  option domain-name "mynetwork.lan";     # This is optional
  option domain-name-servers 1.1.1.1;
  if exists user-class and ( option user-class = "iPXE" ) {
    filename "http://boot.netboot.xyz/menu.ipxe";
  } elsif option arch = encode-int ( 16, 16 ) {
    filename "http://boot.netboot.xyz/ipxe/netboot.xyz.efi";
    option vendor-class-identifier "HTTPClient";
  } elsif option arch = 00:07 {
    filename "netboot.xyz.efi";
  } else {
    filename "netboot.xyz.kpxe";
  }
}
```
## Change to local assets
```
# boot.cfg
set live_endpoint http://192.168.10.125:8080
```
## Booting Microsoft WIM files like OSDCloud ISO
1. Create folders and extract your WinPE iso to /assets/WinPE/x64/
2. Add 'set win_base_url http://192.168.10.125:8080/WinPE' to your boot.cfg
