# Kubernetes JSON Reverser Application

This repository contains two simple applications that demonstrate containerization, Kubernetes deployment, and inter-service communication within a Kubernetes cluster.

## Overview

- **App1**: A Flask application that exposes a JSON document when accessed via an HTTP client.
- **App2**: A Flask application that retrieves the JSON from App1, reverses the `message` string, and returns the modified JSON.

## Applications

### App1

- **Endpoint**: `/json`
- **Response**:
  ```json
  {
    "id": "1",
    "message": "Hello world"
  }
  ```


### App2
- **Endpoint**: /reverse
- **Response**:
  ```json
  Copy code
  {
    "id": "1",
    "message": "dlrow olleH"
  }
```

## Prerequisites

- Docker
- Minikube or Kind for running Kubernetes locally
- Kubectl for interacting with the Kubernetes cluster
- A Docker Hub account (optional, if you want to push images to Docker Hub)



# Setup Instructions

## Step 1: Clone the Repository
```
git clone https://github.com/yourusername/kubernetes-json-reverser.git
cd kubernetes-json-reverser
```
```
## Step 2: Build and Push Docker Images
Replace your-dockerhub-username with your Docker Hub username or leave it as latest for local use.

```
docker build -t your-dockerhub-username/app:latest -f Dockerfile.app .
docker build -t your-dockerhub-username/app_reverse:latest -f Dockerfile.app2 .

docker push your-dockerhub-username/app:latest
docker push your-dockerhub-username/app_reverse:latest

```

## Step 3: Start Kubernetes Cluster
- Using Minikube:
  bash
- Copy code
  minikube start
- Using Kind:
  bash
- Copy code
  kind create cluster
## Step 4: Deploy Applications to Kubernetes
Deploy the applications using kubectl:
```
bash
Copy code
kubectl apply -f app1-deployment.yaml
kubectl apply -f app2-deployment.yaml
```
## Step 5: Test the Applications
Use the provided script to build, deploy, and test the applications.
```
bash
Copy code
chmod +x script.sh
./script.sh
```
This script will:

- Build and push Docker images.
- Deploy the applications to Kubernetes.
- Print the HTTP responses from both applications.
## Step 6: Access the Applications
If you need to access the services manually:

1. App1: Retrieve JSON from http://app1-service:5000/json
2. App2: Retrieve reversed JSON from http://app2-service:5000/reverse

To access the services externally (for example, with Minikube), you can use:
```
- bash
- Copy code
- minikube service app1-service --url
- minikube service app2-service --url
```
Cleanup

To clean up the Kubernetes resources, run:
```
- bash
- Copy code
- kubectl delete -f app1-deployment.yaml
- kubectl delete -f app2-deployment.yaml
```
If using Minikube, you can also stop the cluster:
```
bash
Copy code
minikube stop
``````
### Notes

- Ensure that Docker is running and that you are authenticated with Docker Hub if you plan to push images.
- Adjust the sleep time in the script if necessary, depending on your system's performance.
- The communication between the two services happens internally within the Kubernetes cluster, so it should work in any Kubernetes environment with minimal modifications.