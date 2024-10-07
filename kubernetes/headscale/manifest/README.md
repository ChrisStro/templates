# Notes
- If using https, your cert needs to be trusted.
- To support UDP holepunshing, you need to make sure your stun port (3478) is reachable. The problem with this is that Kubernetes itself does a lot of NAT. So the integrated STUN server will have a hard time if you add additional NAT gateways (as is done by default with Compute instances on Oracle or Azure). So I add coturn as daemonset with access to the host network.
- Works fine so far...