#!/bin/bash

# Quick Deploy to ttl.sh Script
# This creates a Docker image and pushes it to ttl.sh for temporary hosting

set -e

echo "🚀 Deploying Rancher Support UI Extension to ttl.sh"
echo ""

# Generate timestamp for unique image name
TIMESTAMP=$(date +%s)
IMAGE_NAME="ttl.sh/rancher-support-ui-${TIMESTAMP}:1h"

echo "📦 Building Docker image: ${IMAGE_NAME}"
echo ""

# Build a simple nginx image with the extension
docker build -t "${IMAGE_NAME}" -f - . <<'EOF'
FROM nginx:alpine

# Copy extension files
COPY dist-pkg /usr/share/nginx/html/
COPY index.html /usr/share/nginx/html/

# Configure nginx
RUN cat > /etc/nginx/conf.d/default.conf <<'NGINX'
server {
    listen 80;
    server_name _;
    
    location / {
        root /usr/share/nginx/html;
        autoindex on;
        autoindex_exact_size off;
        autoindex_localtime on;
        
        # CORS headers
        add_header Access-Control-Allow-Origin * always;
        add_header Access-Control-Allow-Methods "GET, OPTIONS" always;
        add_header Access-Control-Allow-Headers "Content-Type" always;
    }
}
NGINX

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
EOF

echo ""
echo "📤 Pushing to ttl.sh..."
docker push "${IMAGE_NAME}"

echo ""
echo "✅ Deployment complete!"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📋 Installation Instructions for Rancher"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🔗 Image URL: ${IMAGE_NAME}"
echo ""
echo "Option 1: Run locally and install from URL"
echo "  1. Run: docker run -d -p 8080:80 ${IMAGE_NAME}"
echo "  2. In Rancher: ☰ → Extensions → Available → ⋮ → Manage Repositories"
echo "  3. Create repository with URL: http://YOUR_IP:8080/rancher-support-ui-0.1.0/package.json"
echo ""
echo "Option 2: Direct file upload (Recommended)"
echo "  1. Create tarball: tar -czf rancher-support-ui.tgz -C dist-pkg/rancher-support-ui-0.1.0 ."
echo "  2. In Rancher: ☰ → Extensions → Available → Install from File"
echo "  3. Upload rancher-support-ui.tgz"
echo ""
echo "⏰ Note: ttl.sh images expire after 1 hour"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
