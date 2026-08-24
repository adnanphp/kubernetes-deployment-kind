# ☸️ Kubernetes Deployment with kind

[![Kubernetes](https://img.shields.io/badge/Kubernetes-1.27-blue)](https://kubernetes.io)
[![kind](https://img.shields.io/badge/kind-0.20.0-green)](https://kind.sigs.k8s.io)
[![Docker](https://img.shields.io/badge/Docker-24.0+-blue)](https://docker.com)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.109-green)](https://fastapi.tiangolo.com)

## 📋 Overview

Complete Kubernetes deployment of a containerized FastAPI application using **kind** (Kubernetes in Docker). This project demonstrates production-grade Kubernetes concepts including Deployments, Services, ConfigMaps, Secrets, Persistent Volumes, and Horizontal Pod Autoscaling.

## 🏗️ Architecture
┌─────────────────────────────────────────────────────────────┐
│ KIND KUBERNETES CLUSTER │
├─────────────────────────────────────────────────────────────┤
│ │
│ Control Plane Worker 1 Worker 2 │
│ ↓ ↓ ↓ │
│ ┌──────────────────────────────────────┐ │
│ │ FastAPI Application │ │
│ │ ┌──────────┐ ┌──────────┐ │ │
│ │ │ Pod 1 │ │ Pod 2 │ │ │
│ │ └──────────┘ └──────────┘ │ │
│ │ ↓ ↓ │ │
│ │ Service (Load Balancer) │ │
│ └──────────────────────────────────────┘ │
│ │
└─────────────────────────────────────────────────────────────┘

text

## 🎯 Kubernetes Resources Deployed

| Resource | Purpose | Status |
|----------|---------|--------|
| **Deployment** | Manages 2 replicas of FastAPI app | ✅ |
| **Service** | Load balancing and service discovery | ✅ |
| **ConfigMap** | Configuration data (env variables) | ✅ |
| **Secret** | Sensitive data (passwords, API keys) | ✅ |
| **PersistentVolume** | Storage for application data | ✅ |
| **PersistentVolumeClaim** | Storage request for pods | ✅ |
| **HorizontalPodAutoscaler** | Auto-scaling based on CPU | ✅ |

## 🛠️ Tech Stack

| Technology | Purpose |
|------------|---------|
| **kind** | Local Kubernetes cluster |
| **Kubernetes** | Container orchestration |
| **Docker** | Containerization |
| **FastAPI** | Python API framework |
| **kubectl** | Kubernetes CLI |

## 🚀 Quick Start

```bash
# Clone repository
git clone https://github.com/adnanphp/kubernetes-deployment-kind.git
cd kubernetes-deployment-kind

# Create kind cluster
kind create cluster --config kind-config.yaml --name mlops-cluster

# Build and load Docker image
docker build -t mlops-api:latest .
kind load docker-image mlops-api:latest --name mlops-cluster

# Deploy to Kubernetes
kubectl apply -f manifests/configmap.yaml
kubectl apply -f manifests/secret.yaml
kubectl apply -f manifests/pv.yaml
kubectl apply -f manifests/deployment.yaml
kubectl apply -f manifests/hpa.yaml

# Test the deployment
kubectl port-forward service/mlops-api-service 8000:80
curl http://localhost:8000/health
📁 Project Structure
text
kubernetes-deployment-kind/
├── kind-config.yaml          # kind cluster configuration
├── Dockerfile                # Container image for FastAPI
├── manifests/
│   ├── deployment.yaml       # Deployment + Service
│   ├── configmap.yaml        # Configuration data
│   ├── secret.yaml           # Sensitive data
│   ├── pv.yaml               # Persistent Volume + Claim
│   └── hpa.yaml              # Horizontal Pod Autoscaler
├── README.md
└── .gitignore
🔧 Commands Cheat Sheet
bash
# Cluster management
kind create cluster --config kind-config.yaml --name mlops-cluster
kind delete cluster --name mlops-cluster

# Kubernetes operations
kubectl get nodes
kubectl get pods
kubectl get services
kubectl get deployments
kubectl get hpa

# Logs and debugging
kubectl logs -f deployment/mlops-api
kubectl describe pod <pod-name>

# Scaling
kubectl scale deployment mlops-api --replicas=3

# Rolling update
kubectl set image deployment/mlops-api mlops-api=nginx:alpine
kubectl rollout status deployment/mlops-api
kubectl rollout undo deployment/mlops-api

# Port forwarding
kubectl port-forward service/mlops-api-service 8000:80
📊 API Endpoints
Endpoint	Method	Response
/health	GET	{"status":"healthy"}
/	GET	{"message":"Kubernetes deployment working!"}
📝 License
MIT

👨‍💻 Author
Adnan - GitHub

🔗 Live Demo: Runs locally on Kubernetes cluster
