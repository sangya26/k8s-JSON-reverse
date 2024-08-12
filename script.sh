#!/bin/bash

# Build and push Docker images
docker build -t sangya26/app:latest -f Dockerfile.app .
docker build -t sangya26/app_reverse:latest -f Dockerfile.app_reverse .

docker push sangya26/app:latest
docker push sangya26/app_reverse:latest

# Apply Kubernetes manifests
kubectl apply -f k8s/app_deployment.yaml
kubectl apply -f k8s/app_reverse_deployment.yaml

# Wait for the services to start
sleep 30

# Get the IP of Minikube cluster
MINIKUBE_IP=$(minikube ip)

# Access the applications and print responses
echo "Response from App:"
curl http://app-service:5000/json

echo "Response from App_reverse:"
curl http://app_reverse-service:5000/reverse
