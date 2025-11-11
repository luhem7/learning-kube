# learning-kube
The goal of this repo is to build knowledge in these technologies incrementally by working on a project.

This is a learning repository for **Podman, Kubernetes (k8s), and React**. However, rather than building a series of examples, we will focus on creating an end to end application that demonstrates these technologies in a cohesive manner.

## Project Overview
Our goal is to build a full stack application that serves up a website that can be used to run cellular automata in the web browser.

### Architecture
This application demonstrates a multi-container microservices architecture deployed on Kubernetes:

**Frontend Container (React)**
- Interactive cellular automata visualization and controls
- Canvas-based rendering for smooth animations
- Client-side simulation engine managing all automata state and calculations
- User interface for selecting rules, patterns, and simulation parameters

**API Server Container (Node.js + Fastify)**
- RESTful API for serving cellular automata rules and patterns
- Configuration management for simulation parameters
- Endpoints for pattern retrieval, rule definitions, and preset configurations

**Database Container (PostgreSQL)**
- Persistent storage for cellular automata patterns and rule sets
- User configuration and simulation history
- Optimized queries for pattern retrieval and rule management

## Project Setup
Checkout the [contributing.md](docs/CONTRIBUTING.md) file for local env setup and getting the project running!

## Learning Phases:
1. [podman](docs/podman.md)
2. [kubernetes](docs/kubernetes.md)
3. react
