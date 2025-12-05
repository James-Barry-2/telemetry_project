# Telemetry Project

## Overview
This project collects telemetry data from a simulated satellite and uploads it to AWS S3 for storage. It is containerised using Docker and deployed using a local Kubernetes cluster via Minikube. AWS infrastructure is used through Terraform as Infrastructure as Code (IaC)

## Features thus far
- Dockerised telemetry application.
- Kubernetes deployment and service for the app.
- AWS S3 bucket created via Terraform ('telemetry-ingestion-jb-terraform').
- IAM role with S3 read/write permissions configured through Terraform.
- Application successfully uploads telemetry packets to the S3 bucket.
- Environment variables and AWS credentials are injected via Kubernetes secrets.

## Prerequisites
- Docker Desktop
- Minikube
- Kubectl
- Terraform
- AWS CLI

## Guide
- Clone the repository

git clone https://github.com/James-Barry-2/telemetry_project 

cd telemetry

- Start Minikube

minikube start --driver=docker

- Apply Kubernetes Deployment

kubectl apply -f deployment.yaml

- Apply Terraform to provision AWS resources

cd telemetry-iac
terraform init
terraform apply


## Accessing the App
- Expose the service via Minikube

minikube service telemetry-app --url

- Access the service through pasting the url into a browser.


## In Depth

- Data
The telemetry data is created as a part of the Python script telemetry_uploader.py. Currently there is a 5 second gap between heartbeats and 20 bests are generated before it stops. This is so the CloudWatch Alarm system can be tested which sends an alarm email to my inbox when telemetry is lost for too long. 

- Application and Containerisation
The Python app processes each packet into a JSON data format and uploads it to AWS S3 bucket. This is containerised using Docker for consistent runtime between environments, i.e. the app will run the same on any machine. It also handles all the app requirements such as libraries.

- Kubernetes Deployment
From there, the Kubernetes cluster manages the app by running it as a pod in a cluster. This allows for scalability through increasing the number of running apps by scaling up number of pods. Kubernetes will also step in to restart a pod if it crashes. The file deployment.yaml defines the number of replicas (pods), which Docker image (app version) to run and the variables needed (AWS regino, credentials etc.)

- Storage
The data is uploaded and stored in an S3 bucket where all data is stored as an object (JSON file). Each obeject can be hand picked for analysis later if ever needed. S3 is scalable and easy to use for large scale analytics.

- IAM Roles 
The AWS IAM roles manage permissions and security. The Kubernetes secrets are used to allow the app only the permissions it needs and no more. Terraform creates the IAM role with an S3 access policy.

- Terraform
This automates the creation of the AWS resources (bucket, role, policies). It enables reproducible, version-controlled infrastructure for AWS. main.tf creates the bucket, iam.tf creates the role and applies the policies. variables.tf allows customisation of names and AWS regions and outputs.tf exposes resource names for reference.

- Accessing the App
Kubernetes service opens the pod's port and it is hosted locally. 


