# Inventory Service

A lightweight Golang API service for BlueSky Logistics Platform.

## Endpoints

- `GET /status` - Health check endpoint
- `GET /items` - Returns list of inventory items

## CI/CD Pipeline

### Pipeline Stages

1. **Matrix Tests**: Runs tests across multiple Go versions and OSes
2. **Docker Build & Push**: Builds and pushes Docker image to GHCR
3. **Staging Deployment**: Deploys to Kubernetes staging environment

### Reusable Workflows

This project uses reusable workflows from `your-org/platform-ci`:

- `go-matrix-test.yml`: For matrix testing
- `build-and-push-image.yml`: For Docker operations
- `deploy-k8s.yml`: For Kubernetes deployments

### Matrix Testing

Tests run across:

- **Go Versions**: 1.22, 1.23, 1.24, 1.25
- **Operating Systems**: ubuntu-latest, macos-latest, windows-latest

### Secrets Management

Required repository secrets:

- `REGISTRY_USERNAME`: GitHub Container Registry username
- `REGISTRY_PASSWORD`: GitHub Personal Access Token
- `KUBECONFIG_STAGING`: kubeconfig for staging cluster

### Branching Strategy

1. Create feature branch from `main`
2. Make changes and commit
3. Open Pull Request
4. All CI checks must pass
5. PR review required
6. Merge to `main`

### Deployment Strategy

- **Automatic**: On successful merge to `main`
- **Target**: `inventory-staging` namespace
- **Image Tag**: SHA-based (`ghcr.io/username/inventory-service:<sha>`)

## Local Development

```bash
# Run locally
go run main.go

# Build Docker image
docker build -t inventory-service .

# Run container
docker run -p 8080:8080 inventory-service
```

### Authentication with Azure

```bash
# Login to Azure
az login

# This will open a browser window for authentication
# After login, you'll see your subscription information

# List all subscriptions
az account list --output table

# Set your subscription (if you have multiple)
az account set --subscription "Your-Subscription-Name"
```

### Get AKS Credentials for kubectl

```bash
# Get AKS credentials and configure kubectl
az aks get-credentials \
  --resource-group your-resource-group \
  --name your-aks-cluster-name

# Example:
az aks get-credentials \
  --resource-group myResourceGroup \
  --name myAKSCluster
```

This command:

- Downloads credentials from your AKS cluster
- Merges them into your local ~/.kube/config file
- Sets the current context to your AKS cluster

### Get AKS credentials and save to a file (kubeconfig.yml)

```bash
az aks get-credentials \
  --resource-group YOUR_RESOURCE_GROUP \
  --name YOUR_AKS_CLUSTER_NAME \
  --file aks-kubeconfig.yml
```

#### Base64 encode the entire file

```bash
cat aks-kubeconfig.yml | base64 -w 0
```

az aks get-credentials \
 --resource-group deploy-AKS-RG \
 --name fnc-inventory-cluster \
 --file aks-kubeconfig.yml
