#!/bin/bash

# create 3 nodes
minikube start --nodes 3

# Build Docker Images for Backend/Frontend/Database
docker build -t hanna877/fastapi:latest -f backend/Dockerfile ./backend
docker build -t hanna877/nextjs-frontend:latest -f frontend/Dockerfile ./frontend
docker build -t hanna877/mysql-sakila:latest -f db/Dockerfile ./db

# Push Docker Images to Docker Hub
docker push hanna877/fastapi:latest
docker push hanna877/nextjs-frontend:latest
docker push hanna877/mysql-sakila:latest

# Deploy the app
kubectl apply -f db/db-deployment.yaml
kubectl apply -f frontend/fe-deployment.yaml
kubectl apply -f backend/be-deployment.yaml

# forward backend service to 8080
kubectl port-forward svc/fastapi 8080:8000 &

# run the web app
minikube service nextjs-frontend-service
