# Project Setup
Note: The follow setup steps are only for linux (specifically tested on debian like systems)

## Install dependencies

1. [Install podman](https://podman.io/docs/installation)
2. [Install minikube](https://minikube.sigs.k8s.io/docs/start/?arch=%2Flinux%2Fx86-64%2Fstable%2Fbinary+download)
3. [Install kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)

### Verify installation

#### 1. Verify Podman
```bash
podman --version
```
Should return the version number installed.

#### 2. Start and Verify Minikube
```bash
minikube start
```
This will probably run through the initial download if you are doing this for the first time.

Verify minikube is running:
```bash
minikube status
```
Should show:
```
minikube
type: Control Plane
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured
```

#### 3. Verify kubectl
```bash
kubectl version
```
Should print versions for both client and server:
```bash
Client Version: v1.34.1
Kustomize Version: v5.7.1
Server Version: v1.34.0
```

Verify cluster connectivity:
```bash
kubectl cluster-info
```

### Troubleshooting

**If kubectl can't connect to the server:**
- Ensure minikube is running: `minikube status`
- Restart minikube if needed: `minikube stop && minikube start`
- Check if kubectl context is set: `kubectl config current-context`

**If podman commands fail with permission errors:**
- Ensure your user is in the correct groups (varies by distribution)
- Try running `podman system migrate` to set up rootless containers

**If minikube fails to start:**
- Check available drivers: `minikube start --help | grep driver`
- Try a different driver: `minikube start --driver=docker` (if Docker is available)
- Check system resources (minikube needs at least 2GB RAM)

## Building the container image and running it on minikube

### 1. Build the Container Image
```bash
cd ca_server
podman build -t learning-kube-httpd:latest .
```

### 2. Transfer Image to Minikube
```bash
podman save learning-kube-httpd:latest | minikube image load -
```
This command saves the image from Podman and loads it into minikube's internal registry.

### 3. Deploy to Kubernetes
```bash
cd ca_server/k8s
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

### 4. Access the Application
```bash
minikube service learning-kube-httpd-service --url
```
This will return the URL where your application is accessible (typically `http://192.168.59.100:30080`).
