# podman

Podman is a daemonless, rootless container engine that provides a Docker-compatible command-line interface for managing OCI containers and images without requiring a background service.

## Installation on pop-os
`sudo apt update && sudo apt install podman --yes`

## Rootless vs Rootful Podman

### Rootless Podman (Default/Recommended)
**What it is**: Containers run under your user account without requiring root privileges.

**Advantages**:
- **Security**: No root access needed, containers can't escalate privileges beyond your user
- **Isolation**: Better user separation - your containers can't interfere with other users' containers
- **No daemon**: No background service running as root
- **Multi-user friendly**: Each user has their own container namespace

**Limitations**:
- **Port restrictions**: Cannot bind to privileged ports (< 1024) directly
- **Storage drivers**: Limited to `vfs` or `fuse-overlayfs` (slightly slower)
- **Network limitations**: Some advanced networking features may not work
- **File permissions**: Can have issues with container apps that expect specific UIDs

### Rootful Podman
**What it is**: Containers run with root privileges, similar to Docker's default behavior.

**Advantages**:
- **Full privilege access**: Can bind to any port, access any system resource
- **Better performance**: Can use faster storage drivers like `overlay2`
- **Compatibility**: Better compatibility with containers expecting root access
- **Network features**: Full access to advanced networking capabilities

**Disadvantages**:
- **Security risk**: Containers run as root, potential for privilege escalation
- **System-wide impact**: Can affect system-level resources
- **Single namespace**: All users share the same container namespace

### When to use which?

- **Use Rootless** (recommended): For learning, development, and most applications
- **Use Rootful**: Only when you need privileged ports, specific storage performance, or containers that absolutely require root access

### Quick commands to check your setup:
```bash
podman info | grep -i rootless
```
should return:
```bash
    rootless: true
```


# Run rootless (default)
podman run hello-world

# Useful commands
- `podman help` is really good and provides a really good overview of all the containers!


