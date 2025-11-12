#!/bin/bash

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
IMAGE_NAME="learning-kube-httpd:latest"
SERVICE_NAME="learning-kube-httpd-service"
NO_CACHE=false

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to verify podman installation
verify_podman() {
    print_status "Verifying Podman installation..."
    
    if ! command_exists podman; then
        print_error "Podman is not installed or not in PATH"
        print_error "Please install Podman: https://podman.io/docs/installation"
        exit 1
    fi
    
    if ! podman --version >/dev/null 2>&1; then
        print_error "Podman is installed but not working properly"
        print_error "Try running: podman system migrate"
        exit 1
    fi
    
    print_status "Podman verified: $(podman --version)"
}

# Function to verify kubectl installation
verify_kubectl() {
    print_status "Verifying kubectl installation..."
    
    if ! command_exists kubectl; then
        print_error "kubectl is not installed or not in PATH"
        print_error "Please install kubectl: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/"
        exit 1
    fi
    
    print_status "kubectl verified: $(kubectl version --client --short 2>/dev/null || kubectl version --client)"
}

# Function to verify minikube installation
verify_minikube() {
    print_status "Verifying Minikube installation..."
    
    if ! command_exists minikube; then
        print_error "Minikube is not installed or not in PATH"
        print_error "Please install Minikube: https://minikube.sigs.k8s.io/docs/start/"
        exit 1
    fi
    
    print_status "Minikube verified: $(minikube version --short)"
}

# Function to check and start minikube
ensure_minikube_running() {
    print_status "Checking Minikube status..."
    
    if minikube status >/dev/null 2>&1; then
        print_status "Minikube is already running"
    else
        print_warning "Minikube is not running. Starting..."
        minikube start
        print_status "Minikube started successfully"
    fi
    
    # Verify kubectl can connect
    if ! kubectl cluster-info >/dev/null 2>&1; then
        print_error "kubectl cannot connect to Kubernetes cluster"
        print_error "Try: minikube stop && minikube start"
        exit 1
    fi
    
    print_status "Kubernetes cluster is accessible"
}

# Function to build container image
build_container_image() {
    if [ "$NO_CACHE" = true ]; then
        print_status "Building container image (no cache)..."
        BUILD_ARGS="--no-cache"
    else
        print_status "Building container image..."
        BUILD_ARGS=""
    fi
    
    cd ca_server
    if ! podman build $BUILD_ARGS -t "$IMAGE_NAME" .; then
        print_error "Failed to build container image"
        exit 1
    fi
    cd ..
    
    print_status "Container image built successfully"
}

# Function to transfer image to minikube
transfer_image_to_minikube() {
    print_status "Transferring image to Minikube..."
    
    if ! podman save "$IMAGE_NAME" | minikube image load -; then
        print_error "Failed to transfer image to Minikube"
        exit 1
    fi
    
    print_status "Image transferred to Minikube successfully"
}

# Function to deploy to kubernetes
deploy_to_kubernetes() {
    print_status "Deploying to Kubernetes..."
    
    cd ca_server/k8s
    
    if ! kubectl apply -f deployment.yaml; then
        print_error "Failed to apply deployment"
        exit 1
    fi
    
    if ! kubectl apply -f service.yaml; then
        print_error "Failed to apply service"
        exit 1
    fi
    
    # If we rebuilt with no-cache, force a rollout restart to use the new image
    if [ "$NO_CACHE" = true ]; then
        print_status "Forcing deployment restart to use new image..."
        kubectl rollout restart deployment/learning-kube-httpd
    fi
    
    cd ../..
    print_status "Deployment successful"
}

# Function to get application URL
get_application_url() {
    print_status "Getting application URL..."
    
    # Wait a moment for service to be ready
    sleep 2
    
    URL=$(minikube service "$SERVICE_NAME" --url 2>/dev/null)
    if [ $? -eq 0 ] && [ -n "$URL" ]; then
        print_status "Application is accessible at: $URL"
        echo ""
        echo -e "${GREEN}🎉 Success! Your application is now running in Kubernetes${NC}"
        echo ""
        echo "Useful commands:"
        echo "  kubectl get pods                    # View running pods"
        echo "  kubectl logs -l app=learning-kube-httpd # View application logs"
        echo "  kubectl get services                # View services"
        echo "  minikube dashboard                  # Open Kubernetes dashboard"
    else
        print_warning "Could not retrieve service URL automatically"
        print_warning "Try: minikube service $SERVICE_NAME --url"
    fi
}

# Function to parse command line arguments
parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --no-cache)
                NO_CACHE=true
                shift
                ;;
            -h|--help)
                echo "Usage: $0 [OPTIONS]"
                echo ""
                echo "Options:"
                echo "  --no-cache    Force rebuild of container image without using cache"
                echo "  -h, --help    Show this help message"
                echo ""
                echo "Examples:"
                echo "  $0                # Deploy using cached build"
                echo "  $0 --no-cache     # Force rebuild and deploy"
                exit 0
                ;;
            *)
                print_error "Unknown option: $1"
                print_error "Use --help for usage information"
                exit 1
                ;;
        esac
    done
}

# Main execution
main() {
    # Parse command line arguments first
    parse_arguments "$@"
    
    echo -e "${GREEN}================================${NC}"
    echo -e "${GREEN} Learning Kube Deployment Script${NC}"
    echo -e "${GREEN}================================${NC}"
    echo ""
    
    if [ "$NO_CACHE" = true ]; then
        print_warning "No-cache mode enabled - will rebuild image from scratch"
        echo ""
    fi
    
    # Step 1: Verify installations
    verify_podman
    verify_kubectl
    verify_minikube
    
    # Step 2: Ensure minikube is running
    ensure_minikube_running
    
    # Step 3: Build and deploy
    build_container_image
    transfer_image_to_minikube
    deploy_to_kubernetes
    
    # Step 4: Get access URL
    get_application_url
}

# Run main function with all arguments
main "$@"