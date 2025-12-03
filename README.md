This project implements a containerised telemetry ingestion pipeline capable of collecting, processing, and storing telemetry data in AWS. The platform is built using modern DevOps and cloud-native tooling, demonstrating a scalable, modular, and production-aligned architecture suitable for real-time or batch telemetry workloads.

Features

- Containerised Telemetry Application
Built a Python-based telemery uploader for receiving and pushing packets to cloud storage. 
Bundled the application into a Docker image for robust deployment across environments

- Kubernetes Deployment
Deployed to Kubernetes cluster using Minikube
Created Kubernetes manifests for:
    - Deployment config
    - Service exposure
    - AWS credential secrets
Achieved successful operation of the pod and external service access

- AWS S3 Integration
Application uploads packets directly to an Amazon S3 bucket for scalable and reliant storage
Utilised AWS SDK within the application to put objects into S3
Congfigured Kubernetes secrets to manage AWS credentials securely

Systems Utilised:
- Containerisation : Docker
- Orchestration : Kubernetes (Minikube)
- Cloud Storage : AWS S3 
- Credentials : Kubernetes Secrets