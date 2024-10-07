# Deployment for single node k3s cluster
## Notes
This is a self-built/converted implementation of the official Docker-Compose file. The official Helm chart requires you to implement a ReadWriteMany storage class and a PostgreDB in HA mode, so I create these manifest files for my single-node k3s clusters using sqllite as the database (works fine for smaller environments). For multi-node deployments, please prefer the Helm chart deployment.

## Deployment
Run the script to create the required folders. We're tricking Kubernetes here with 2 pvcs targeting the same local folder on the host, so we're bypassing the ReadWriteMany storage class.

## Cloudflare
In theory you could use the Cloudflare tunnel for the dashboard and API domain, but MQTT should not be forwarded by Cloudflare. Don't waste your time, I tried several hours to get it working with no stable success.