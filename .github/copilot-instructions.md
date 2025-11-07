# AI Coding Agent Instructions

## Disposition for Edits and Suggestions (Important)
- Know that the user is new to these technologies but has general computer engineering knowledge.
- Push back on overly complex solutions; prefer simplicity and clarity.
- Question assumptions and requirements from the user when they do not follow best practices.
- Think critically about the learning objectives and suggest improvements that enhance understanding.
- Only directly suggest changes for the immediate questions being asked. 
- Do not attempt to implement large features automatically. Produce smaller, incremental changes that can be reviewed, approved and understood by the user.

## Architecture & Organization
- **Container-first approach**: All applications should be containerizable using Podman
- **Kubernetes deployment ready**: Include k8s manifests alongside applications
- **React frontend examples**: Modern React patterns with container deployment in mind

## Development Workflow
- **Containerization**: Use Podman instead of Docker for all container operations
  - `podman build -t <name> .` instead of `docker build`
  - `podman run` instead of `docker run`
- **Local k8s testing**: Assume use of local Kubernetes clusters (minikube, kind, or podman-compose)

## Key Conventions
- **Container configs**: Place Dockerfile/Containerfile in project roots
- **K8s manifests**: Store in `k8s/` or `manifests/` directories within each project
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