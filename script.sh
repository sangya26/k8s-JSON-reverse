#!/bin/bash

# Variables
DOCKER_USERNAME="sangya26"
APP1_IMAGE="${DOCKER_USERNAME}/app:latest"
APP2_IMAGE="${DOCKER_USERNAME}/app_reverse:latest"
MINIKUBE_IP=$(minikube ip)

# Build Docker Images
echo "Building Docker images..."
docker build -t $APP1_IMAGE -f Dockerfile.app .
docker build -t $APP2_IMAGE -f Dockerfile.reverse .

# Push Docker Images to Docker Hub
echo "Pushing Docker images to Docker Hub..."
docker push $APP1_IMAGE
docker push $APP2_IMAGE

# Deploy Applications to Kubernetes
echo "Deploying applications to Kubernetes..."
kubectl apply -f app_deployment.yaml
kubectl apply -f app_reverse_deployment.yaml

# Wait for the Pods to be Ready
echo "Waiting for the pods to be ready..."
kubectl wait --for=condition=ready pod -l app=app --timeout=60s
kubectl wait --for=condition=ready pod -l app=app_reverse --timeout=60s

# Print HTTP Responses
echo "Fetching responses from the applications..."

# Fetch the response from App
APP1_RESPONSE=$(kubectl exec -it $(kubectl get pod -l app=app -o jsonpath="{.items[0].metadata.name}") -- curl -s http://localhost:5000/json)
echo "Response from App:"
echo $APP1_RESPONSE

# Fetch the response from App reverse
APP2_RESPONSE=$(kubectl exec -it $(kubectl get pod -l app=app_reverse -o jsonpath="{.items[0].metadata.name}") -- curl -s http://localhost:5000/reverse)
echo "Response from App Reverse:"
echo $APP2_RESPONSE

