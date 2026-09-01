# Radar

Radar is a Kubernetes dashboard that provides a fresh, lightweight take on how to interact with your clusters.

[Official Website](https://radarhq.io)

## Installation

The easiest way to install Radar in your cluster is using Helm.

### Prerequisites

- Helm 3+
- A running Kubernetes cluster

### Install via Helm

1. **Add the Radar repository:**
   ```bash
   helm repo add skyhook https://skyhook-io.github.io/helm-charts
   helm repo update skyhook
   ```

2. **Install the chart:**
   You can use the provided automation script in this repository:
   ```bash
   cd radar/helm
   ./apply.sh
   ```

   Or manually:
   ```bash
   helm install radar skyhook/radar -n radar --create-namespace --values values.yml
   ```

## Configuration

Custom configurations can be applied by modifying the `radar/helm/values.yml` file. 

To generate a fresh `values.yml` file with all available options, run:
```bash
cd radar/helm
./build_values_file.sh
```

## Features

- **Topology View**: Visualize your cluster resources and their relationships.
- **Timeline**: An audit trail of what happened in your cluster and when.
- **Traffic Visibility**: Integration with Hubble/Cilium.
- **Helm Management**: Inspect and manage Helm releases directly from the UI.
- **GitOps Integration**: Support for ArgoCD and FluxCD.
- **MCP Support**: Model Context Protocol for AI agent integration.
