# EKS Blue-Green Deployment with Kubernetes Gateway API

This repository demonstrates a **Blue-Green deployment** setup on **AWS EKS** using **Kubernetes Gateway API** and maps it to a custom domain (`amanops.com`) with TLS support.

## Prerequisites
- AWS EKS cluster with Gateway API installed (NGINX, Istio, or Kong controller)
- kubectl configured for the cluster
- Domain managed in Route 53 (or any DNS provider)
- TLS certificate (AWS ACM or cert-manager)

## Repo Structure
deployments/     # Blue & Green deployments + services
gateway/         # Gateway & HTTPRoute configuration
tls/             # TLS certificates
scripts/         # Helper scripts (traffic switch)

## Deployment Steps
1. Deploy Blue & Green Applications:
   kubectl apply -f deployments/

2. Setup TLS Certificate:
   kubectl apply -f tls/cert.yaml

3. Deploy Gateway & HTTPRoute:
   kubectl apply -f gateway/

4. Switch Traffic (Blue ↔ Green):
   bash scripts/switch-traffic.sh green

## Notes
- Blue-Green traffic switching is done via **HTTPRoute weights**
- Path-based routing supported (`/`, `/api`, `/blog`)
- Make sure your DNS points to the **LoadBalancer EXTERNAL-IP** of the Gateway