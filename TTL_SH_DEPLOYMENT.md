# 🚀 Deploy Rancher UI Extension to ttl.sh

## Quick Deploy Instructions

### Option 1: Using Pre-built Extension (Fastest)

Since the extension is already built locally, you can deploy it directly:

```bash
cd /Users/sandip/longhorn/longhorn/rancher-support-ui

# Create a simple nginx image with the built extension
docker build -t ttl.sh/rancher-support-ui-$(date +%s):1h -f - . <<'EOF'
FROM nginx:alpine
COPY dist-pkg /usr/share/nginx/html/
COPY index.html /usr/share/nginx/html/
RUN cat > /etc/nginx/conf.d/default.conf <<'NGINX'
server {
    listen 80;
    location / {
        root /usr/share/nginx/html;
        autoindex on;
        add_header Access-Control-Allow-Origin * always;
    }
}
NGINX
EOF

# Push to ttl.sh (image will be available for 1 hour)
docker push ttl.sh/rancher-support-ui-$(date +%s):1h
```

### Option 2: Full Build in Docker (Currently Running)

The Dockerfile.ttl builds everything from scratch. This takes longer but is more reproducible.

```bash
# Build
docker build -f Dockerfile.ttl -t ttl.sh/rancher-support-ui:1h .

# Push to ttl.sh
docker push ttl.sh/rancher-support-ui:1h
```

## Installing in Rancher

Once pushed to ttl.sh, you'll get a URL like: `ttl.sh/rancher-support-ui-1732524000:1h`

### Method 1: Run as Container and Install from URL

```bash
# Run the container
docker run -d -p 8080:80 ttl.sh/rancher-support-ui-TIMESTAMP:1h

# In Rancher UI:
# 1. Go to ☰ → Extensions → Available
# 2. Click ⋮ → Manage Repositories → Create
# 3. Name: rancher-support-ui
# 4. URL: http://YOUR_IP:8080/rancher-support-ui-0.1.0/package.json
# 5. Click Create
# 6. Install the extension
```

### Method 2: Direct File Upload (Recommended)

```bash
# Create a tarball of the extension
cd /Users/sandip/longhorn/longhorn/rancher-support-ui
tar -czf rancher-support-ui-0.1.0.tgz -C dist-pkg/rancher-support-ui-0.1.0 .

# In Rancher UI:
# 1. Go to ☰ → Extensions → Available  
# 2. Click "Install from File"
# 3. Upload rancher-support-ui-0.1.0.tgz
# 4. Click Install
# 5. Enable the extension
```

## ttl.sh Notes

- **Temporary**: Images on ttl.sh are temporary (1h, 24h, etc.)
- **Public**: Anyone with the URL can access
- **No Auth**: No authentication required
- **Perfect for**: Testing, demos, quick deployments

## Alternative: Use GitHub Pages (Permanent)

For a permanent solution, use GitHub Pages instead:
```bash
./setup-github-pages.sh
```

This will give you a permanent URL that won't expire.
