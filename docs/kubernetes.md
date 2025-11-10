# Kubernetes
Kubernetes is an open-source container orchestration platform that automates the deployment, scaling, and management of containerized applications across clusters of machines.

## minikube
From the [official docs](https://minikube.sigs.k8s.io/docs/):
> minikube quickly sets up a local Kubernetes cluster on macOS, Linux, and Windows. We proudly focus on helping application developers and new Kubernetes users.


## kubectl
From [https://kubernetes.io/docs/tasks/tools/](https://kubernetes.io/docs/tasks/tools/):
The Kubernetes command-line tool, kubectl, allows you to run commands against Kubernetes clusters. You can use kubectl to deploy applications, inspect and manage cluster resources, and view logs. For more information including a complete list of kubectl operations, see the kubectl reference documentation.

- Common format for kubectl commands is `kubectl action resource`

### Useful commands
- `kubectl version` : If you see both the client and server version numbers, then it is configured to interact with the cluster
- `kubectl cluster-info`
- `kubectl get nodes`

(Im going to stop putting kubectl at the front of the commands from now on)

- `proxy`: Creates a proxy for the cluster wide private network running in kubernetes.\
- `get $RESOURCE_TYPE`: lists all the resources under that type (like `pods`, `deployments`).
- `describe $RESOURCE_TYPE`: lists all the details for resources under that type (like `pods`, `deployments`). Describe often includes lifecycle activites for each resource, so its good for understanding what's going on with that resource, but its very verbose.
- `logs $POD_NAME`: Gets the logs for the given pod. Only includes things being printed to `STDOUT`
- `exec $PODNAME -- $SUB_COMMAND`: Used to run commands on the pod. Has its own set of sub commands 
- `label $RESOURCE_TYPE $RESOURCE_NAME $LABEL_NAME` can be used to assign labels to things. Kubernetes uses labels as part of addressing various resources in the cluster
- `expose`: This command can be used to create services on the cluster


## Services
A Kubernetes Service is a stable network abstraction that provides a consistent way to access a set of pods, even as individual pods are created, destroyed, or moved around the cluster.

### Why Services are needed
Without Services, you'd have a problem: pods get dynamic IP addresses that change when they restart, and you might have multiple replicas of the same application. How do you reliably connect to them?
