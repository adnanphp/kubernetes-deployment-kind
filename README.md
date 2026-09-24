# ☸️ Kubernetes Deployment with kind

[![Kubernetes](https://img.shields.io/badge/Kubernetes-1.27-blue)](https://kubernetes.io)
[![kind](https://img.shields.io/badge/kind-0.20.0-green)](https://kind.sigs.k8s.io)
[![Docker](https://img.shields.io/badge/Docker-24.0%2B-blue)](https://www.docker.com)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.109-green)](https://fastapi.tiangolo.com)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](#-license)

> **A containerized FastAPI application deployed and managed on a local multi-node Kubernetes cluster using kind.**

This project demonstrates practical Kubernetes and MLOps deployment concepts using **Kubernetes-in-Docker (kind)**. It covers containerization, deployments, service discovery, configuration management, secrets, persistent storage, and horizontal pod autoscaling.

---

## 📋 Overview

The application is packaged as a Docker container and deployed to a local Kubernetes cluster created with **kind**.

The project demonstrates how a FastAPI service can be:

* 🐳 Containerized with Docker
* ☸️ Deployed using Kubernetes
* 🔄 Managed with Kubernetes Deployments
* ⚖️ Exposed through a Kubernetes Service
* ⚙️ Configured with ConfigMaps
* 🔐 Managed with Kubernetes Secrets
* 💾 Connected to persistent storage
* 📈 Automatically scaled using Horizontal Pod Autoscaling
* 🔍 Monitored and debugged using `kubectl`

The entire environment runs locally, making it useful for learning and experimenting with Kubernetes without requiring a cloud provider.

---

## 🏗️ Architecture

```text
┌─────────────────────────────────────────────────────────────┐
│                    KIND KUBERNETES CLUSTER                  │
│                                                             │
│  ┌──────────────┐      ┌──────────────┐      ┌───────────┐ │
│  │ Control Plane│      │   Worker 1   │      │ Worker 2  │ │
│  └──────────────┘      └──────┬───────┘      └─────┬─────┘ │
│                               │                     │       │
│                         ┌─────▼─────────────────────▼─────┐ │
│                         │       FastAPI Deployment        │ │
│                         │                                 │ │
│                         │  ┌──────────┐   ┌──────────┐   │ │
│                         │  │  Pod 1   │   │  Pod 2   │   │ │
│                         │  │ FastAPI  │   │ FastAPI  │   │ │
│                         │  └──────────┘   └──────────┘   │ │
│                         └────────────┬────────────────────┘ │
│                                      │                      │
│                         ┌────────────▼────────────┐         │
│                         │   Kubernetes Service    │         │
│                         │  Load Balancing / DNS   │         │
│                         └────────────┬────────────┘         │
│                                      │                      │
│                         ┌────────────▼────────────┐         │
│                         │      Persistent         │         │
│                         │   Volume / Claim        │         │
│                         └─────────────────────────┘         │
└─────────────────────────────────────────────────────────────┘
```

### Deployment Flow

```text
Developer
   │
   ▼
Dockerfile
   │
   ▼
Docker Image
   │
   ▼
kind Cluster
   │
   ▼
Kubernetes Deployment
   │
   ├── Pod 1 ──┐
   └── Pod 2 ──┤
               ▼
        Kubernetes Service
               │
               ▼
          FastAPI API
```

---

## 🎯 Kubernetes Resources

| Resource                    | Purpose                                       | Status |
| --------------------------- | --------------------------------------------- | ------ |
| **Deployment**              | Manages FastAPI pod replicas                  | ✅      |
| **Service**                 | Provides service discovery and load balancing | ✅      |
| **ConfigMap**               | Stores non-sensitive configuration            | ✅      |
| **Secret**                  | Stores sensitive configuration                | ✅      |
| **PersistentVolume**        | Provides persistent storage                   | ✅      |
| **PersistentVolumeClaim**   | Requests persistent storage                   | ✅      |
| **HorizontalPodAutoscaler** | Scales pods based on CPU utilization          | ✅      |

---

## 🛠️ Technology Stack

| Technology     | Purpose                           |
| -------------- | --------------------------------- |
| **Kubernetes** | Container orchestration           |
| **kind**       | Local Kubernetes cluster          |
| **Docker**     | Containerization                  |
| **FastAPI**    | REST API framework                |
| **kubectl**    | Kubernetes command-line interface |
| **YAML**       | Kubernetes resource configuration |

---

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/adnanphp/kubernetes-deployment-kind.git
cd kubernetes-deployment-kind
```

### 2. Create the kind Cluster

```bash
kind create cluster \
  --config kind-config.yaml \
  --name mlops-cluster
```

Verify the cluster:

```bash
kubectl get nodes
```

Expected output should show the control-plane and worker nodes.

---

### 3. Build the Docker Image

```bash
docker build -t mlops-api:latest .
```

Load the image into kind:

```bash
kind load docker-image mlops-api:latest \
  --name mlops-cluster
```

---

### 4. Deploy Kubernetes Resources

Apply the configuration:

```bash
kubectl apply -f manifests/configmap.yaml
kubectl apply -f manifests/secret.yaml
kubectl apply -f manifests/pv.yaml
kubectl apply -f manifests/deployment.yaml
kubectl apply -f manifests/hpa.yaml
```

Check the deployment:

```bash
kubectl get pods
kubectl get deployments
kubectl get services
kubectl get hpa
```

---

### 5. Access the API

Forward the Kubernetes Service to your local machine:

```bash
kubectl port-forward service/mlops-api-service 8000:80
```

Then test the health endpoint:

```bash
curl http://localhost:8000/health
```

Expected response:

```json
{
  "status": "healthy"
}
```

---

## 📁 Project Structure

```text
kubernetes-deployment-kind/
│
├── kind-config.yaml
├── Dockerfile
│
├── manifests/
│   ├── deployment.yaml
│   ├── configmap.yaml
│   ├── secret.yaml
│   ├── pv.yaml
│   └── hpa.yaml
│
├── README.md
└── .gitignore
```

### Key Files

| File               | Description                           |
| ------------------ | ------------------------------------- |
| `kind-config.yaml` | Multi-node kind cluster configuration |
| `Dockerfile`       | Builds the FastAPI container image    |
| `deployment.yaml`  | Kubernetes Deployment and Service     |
| `configmap.yaml`   | Application configuration             |
| `secret.yaml`      | Sensitive configuration               |
| `pv.yaml`          | Persistent Volume and Claim           |
| `hpa.yaml`         | Horizontal Pod Autoscaler             |

---

## 🔧 Kubernetes Command Cheat Sheet

### Cluster Management

```bash
# Create cluster
kind create cluster \
  --config kind-config.yaml \
  --name mlops-cluster

# List clusters
kind get clusters

# Delete cluster
kind delete cluster --name mlops-cluster
```

### Inspect Resources

```bash
kubectl get nodes
kubectl get pods
kubectl get services
kubectl get deployments
kubectl get hpa
kubectl get pv
kubectl get pvc
```

### Logs & Debugging

```bash
# View deployment logs
kubectl logs -f deployment/mlops-api

# Describe a pod
kubectl describe pod <pod-name>

# View deployment details
kubectl describe deployment mlops-api

# View recent events
kubectl get events
```

### Scaling

Manually scale the deployment:

```bash
kubectl scale deployment mlops-api --replicas=3
```

Check the result:

```bash
kubectl get pods
```

### Rolling Updates

Update the container image:

```bash
kubectl set image deployment/mlops-api \
  mlops-api=nginx:alpine
```

Monitor the rollout:

```bash
kubectl rollout status deployment/mlops-api
```

Rollback if necessary:

```bash
kubectl rollout undo deployment/mlops-api
```

### Port Forwarding

```bash
kubectl port-forward \
  service/mlops-api-service 8000:80
```

---

## 📊 API Endpoints

| Endpoint  | Method | Description        | Example Response                               |
| --------- | ------ | ------------------ | ---------------------------------------------- |
| `/`       | GET    | Application status | `{"message":"Kubernetes deployment working!"}` |
| `/health` | GET    | Health check       | `{"status":"healthy"}`                         |

### Health Check

```bash
curl http://localhost:8000/health
```

### Root Endpoint

```bash
curl http://localhost:8000/
```

---

## 📈 Horizontal Pod Autoscaling

The project includes a Kubernetes **HorizontalPodAutoscaler (HPA)**.

The HPA can automatically adjust the number of FastAPI replicas based on CPU utilization.

Check HPA status:

```bash
kubectl get hpa
```

Detailed information:

```bash
kubectl describe hpa
```

This demonstrates the basic Kubernetes workflow:

```text
Application Load
       │
       ▼
   CPU Usage
       │
       ▼
      HPA
       │
       ▼
Replica Count
       │
       ├── Pod 1
       ├── Pod 2
       └── Pod N
```

---

## 💾 Persistent Storage

The deployment also demonstrates Kubernetes persistent storage using:

```text
PersistentVolume (PV)
        │
        ▼
PersistentVolumeClaim (PVC)
        │
        ▼
      Pod
```

Inspect storage resources:

```bash
kubectl get pv
kubectl get pvc
```

---

## 🔐 Configuration & Secrets

Application configuration is separated from the container image using a Kubernetes `ConfigMap`.

Sensitive values are managed through a Kubernetes `Secret`.

```text
ConfigMap
   │
   ├── Application configuration
   └── Environment variables

Secret
   │
   ├── Passwords
   └── Sensitive credentials
```

This keeps configuration separate from application code and demonstrates standard Kubernetes configuration management.

> **Note:** Kubernetes Secrets provide encoding and access-control mechanisms, but values should still be handled carefully in production environments.

---

## 🧪 Testing the Deployment

After deployment, verify the complete Kubernetes stack:

```bash
kubectl get nodes
kubectl get pods
kubectl get deployments
kubectl get services
kubectl get hpa
kubectl get pv
kubectl get pvc
```

Then access the API:

```bash
kubectl port-forward service/mlops-api-service 8000:80
```

```bash
curl http://localhost:8000/health
```

---

## 🎓 What This Project Demonstrates

This project provides hands-on experience with:

* ☸️ Kubernetes cluster management
* 🐳 Docker containerization
* 📦 Kubernetes Deployments
* ⚖️ Service discovery and load balancing
* 🔄 Replica management
* 📈 Horizontal Pod Autoscaling
* ⚙️ ConfigMaps
* 🔐 Secrets
* 💾 Persistent Volumes and Claims
* 🛠️ `kubectl` debugging and administration
* 🔁 Rolling updates and rollbacks
* 🧩 Multi-node local Kubernetes environments

---

## 🔮 Possible Extensions

Future improvements could include:

* [ ] Add Prometheus metrics
* [ ] Add Grafana dashboards
* [ ] Add Kubernetes readiness/liveness probes
* [ ] Add resource requests and limits
* [ ] Add CI/CD deployment with GitHub Actions
* [ ] Add Ingress
* [ ] Add Helm charts
* [ ] Add ML model serving
* [ ] Add model monitoring and drift detection
* [ ] Add centralized logging

---

## 📜 License

This project is licensed under the **MIT License**.

---

## 👨‍💻 Author

**Adnan**

🔗 GitHub: [github.com/adnanphp](https://github.com/adnanphp)

---

## ⭐ Project Purpose

This project was developed as a hands-on demonstration of **Kubernetes, Docker, FastAPI, and MLOps deployment concepts** using a completely local development environment.

> **Build locally. Deploy with Kubernetes. Scale with confidence.**
