# SMB CSI Driver for Kubernetes

This driver allows Kubernetes to access SMB server on both Linux and Windows nodes. The driver requires an existing and already configured SMB server. It supports dynamic provisioning of Persistent Volumes via Persistent Volume Claims by creating a new sub directory under the SMB server.

[GitHub Page](https://github.com/kubernetes-csi/csi-driver-smb)