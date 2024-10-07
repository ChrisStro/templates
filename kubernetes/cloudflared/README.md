# Cloudflare Tunnel client

Contains the command-line client for Cloudflare Tunnel, a tunneling daemon that proxies traffic from the Cloudflare network to your origins. With "Access Tunnels", you can even tunnel the connection through Cloudflare's global CDN without exposing a single port to the public internet.

                                        _______Internet_______
                                       |    ______________    |
                                       |   |__Cloudflare__|   |
                                       |__/________________\__|
                                         /                  \
                                        /                    \
     ______________Instance1__________________              ______________Instance2__________________
    | APP1<--dockernetwork--CloudflaredTunnel |            | CloudflaredAccess<--dockernetwork--App2 |

In this example, APP2 can reach APP1 through a Cloudflare access tunnel (running in a Cloudflared container). I like to use this solution to consolidate my various Portainer agents (Docker hosts or K3s clusters) into one central Portainer instance.

[GitHub Page](https://github.com/cloudflare/cloudflared)