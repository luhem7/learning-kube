# AI Coding Agent Instructions

## Project Overview
This is a learning repository for **Podman, Kubernetes (k8s), and React**. However, rather than building a series of examples, we will focus on creating an end to end application that demonstrates these technologies in a cohesive manner.

## Architecture & Organization
- **Container-first approach**: All applications should be containerizable using Podman
- **Kubernetes deployment ready**: Include k8s manifests alongside applications
- **React frontend examples**: Modern React patterns with container deployment in mind

## Development Workflow
- **Containerization**: Use Podman instead of Docker for all container operations
  - `podman build -t <name> .` instead of `docker build`
  - `podman run` instead of `docker run`
- **Local k8s testing**: Assume use of local Kubernetes clusters (minikube, kind, or podman-compose)
- **Incremental learning**: Each example should be self-contained and progressively build complexity

## Key Conventions
- **Container configs**: Place Dockerfile/Containerfile in project roots
- **K8s manifests**: Store in `k8s/` or `manifests/` directories within each project
- **Learning documentation**: Include README.md in each subdirectory explaining the learning objective
- **Environment files**: Use `.env.example` files to document required environment variables

## Technology Stack Expectations
- **Container runtime**: Podman (rootless containers preferred)
- **Orchestration**: Kubernetes with focus on learning core concepts
- **Frontend**: Modern React with hooks, potentially with containerized development
- **Package management**: npm/yarn for JavaScript dependencies

## Development Environment
- **Linux-based development**: Commands and scripts should work on Linux/WSL
- **Container-native**: All services should run in containers for consistency
- **Local-first**: Examples should work locally without external dependencies when possible