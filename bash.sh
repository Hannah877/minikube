#!/bin/bash

set -a
source .env
set +a 

# create 3 nodes
minikube start --nodes 3

# Deploy the app
kubectl apply -f db/db-deployment.yaml
kubectl apply -f frontend/fe-deployment.yaml
kubectl apply -f backend/be-deployment.yaml

# Build Docker Images for Backend/Frontend/Database
docker build -t "$DOCKER_USERNAME/fastapi:latest" -f backend/Dockerfile ./backend
docker build -t "$DOCKER_USERNAME/nextjs-frontend:latest" -f frontend/Dockerfile ./frontend
docker build -t "$DOCKER_USERNAME/mysql-sakila:latest" -f db/Dockerfile ./db

# Push Docker Images to Docker Hub
docker push "$DOCKER_USERNAME/fastapi:latest"
docker push "$DOCKER_USERNAME/nextjs-frontend:latest"
docker push "$DOCKER_USERNAME/mysql-sakila:latest"

# Deploy the app
kubectl apply -f db/db-deployment.yaml
kubectl apply -f frontend/fe-deployment.yaml
kubectl apply -f backend/be-deployment.yaml

# forward backend service to 8080
kubectl port-forward svc/"$FASTAPI_SERVICE_NAME" 8080:"$FASTAPI_CONTAINER_PORT" &

# run the web app
minikube service "$NEXTJS_SERVICE_NAME-service"
