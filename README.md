# Rancher Support Bundle UI Extension - Build and Deployment

## 🚀 Quick Deploy to GitHub Pages (Recommended)

The easiest way to deploy this extension is via GitHub Pages:

### Automated Setup

```bash
# Run the setup script
./setup-github-pages.sh
```

### Manual Setup

1. **Push to GitHub**:
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin https://github.com/YOUR_USERNAME/rancher-support-ui.git
   git branch -M main
   git push -u origin main
   ```

2. **Enable GitHub Pages**:
   - Go to repository **Settings → Pages**
   - Under **Source**, select **GitHub Actions**
   - The workflow will automatically build and deploy

3. **Install in Rancher**:
   - URL: `https://YOUR_USERNAME.github.io/rancher-support-ui/rancher-support-ui-0.1.0/package.json`
   - In Rancher: **☰ → Extensions → Available → ⋮ → Manage Repositories → Create**
   - Add the URL above, then install the extension

📖 **Detailed instructions**: See [GITHUB_PAGES_DEPLOYMENT.md](GITHUB_PAGES_DEPLOYMENT.md)

---

## Quick Start

### Option 1: Install from Built Package

1. Locate the built package in `dist-pkg/rancher-support-ui-0.1.0.tgz`
2. In Rancher UI, navigate to **Extensions** (☰ → Extensions)
3. Click **Install from File**
4. Upload the `.tgz` file
5. Enable the extension

### Option 2: Build from Source

```bash
# Install dependencies
yarn install

# Build the extension
yarn build-pkg rancher-support-ui

# The output will be in dist-pkg/
```

### Option 3: Docker Deployment

Build and run the extension in a container:

```bash
# Build the Docker image
docker build -t rancher-support-ui:latest .

# Run the container
docker run -d -p 8080:80 rancher-support-ui:latest
```

Then in Rancher, install from URL: `http://localhost:8080/rancher-support-ui-0.1.0.tgz`

## Development

### Local Development Server

```bash
# Start the dev server
yarn serve-pkgs
```

This will start a development server at `http://localhost:8005`

### Project Structure

```
rancher-support-ui/
├── pkg/
│   └── rancher-support-ui/
│       ├── list/                    # List view component
│       ├── edit/                    # Create/Edit view component
│       ├── detail/                  # Detail view with download
│       ├── l10n/                    # Localization files
│       ├── models/                  # Custom models (if needed)
│       └── index.ts                 # Extension entry point
├── dist-pkg/                        # Built extension packages
├── Dockerfile                       # Container build file
└── package.json                     # Project metadata
```

## Usage in Rancher

Once installed:

1. Navigate to **Rancher Support Bundles** in the left menu
2. Click **Create** to generate a new support bundle
3. Fill in:
   - **Name**: Unique identifier for the bundle
   - **Namespace**: Kubernetes namespace
   - **Clusters**: List of cluster names to collect from
   - **Storage Class**: (Optional) Storage class for PVC
4. Click **Create**
5. Monitor the bundle state (Pending → Running → Completed)
6. Once completed, click **Download Bundle** in the detail view

## Integration with rancher-support-operator

This UI extension works with the `rancher-support-operator` backend:

- The operator creates collector Jobs for each bundle
- Each Job runs an HTTP server on port 8080
- The operator creates a Kubernetes Service to expose the collector
- The UI uses the Kubernetes API proxy to download bundles

### Download URL Format

```
/k8s/clusters/{cluster-id}/api/v1/namespaces/{namespace}/services/{service-name}:8080/proxy/bundle.zip
```

## Troubleshooting

### Extension not appearing
- Ensure the extension is enabled in Extensions page
- Check browser console for errors
- Verify CRD is installed: `kubectl get crd ranchersupportbundles.ranchersupportbundle.rancher.cattle.io`

### Download not working
- Verify bundle state is "Completed"
- Check collector service exists: `kubectl get svc -n {namespace}`
- Ensure collector pod is running: `kubectl get pods -n {namespace}`

### Build errors
- Use Node.js 16 (not 18+)
- Clear cache: `rm -rf node_modules yarn.lock && yarn install`
