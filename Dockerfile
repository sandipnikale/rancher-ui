# Build stage
FROM node:16 AS builder

WORKDIR /app

# Copy package files
COPY package.json yarn.lock ./
COPY pkg ./pkg

# Install dependencies
RUN yarn install

# Build the extension
RUN yarn build-pkg rancher-support-ui

# Final stage - serve the built extension
FROM nginx:alpine

# Copy built extension to nginx
COPY --from=builder /app/dist-pkg /usr/share/nginx/html/

# Copy nginx configuration
COPY <<EOF /etc/nginx/conf.d/default.conf
server {
    listen 80;
    server_name localhost;
    
    location / {
        root /usr/share/nginx/html;
        index index.html;
        try_files \$uri \$uri/ =404;
    }
    
    # Enable CORS for extension loading
    add_header Access-Control-Allow-Origin *;
    add_header Access-Control-Allow-Methods "GET, OPTIONS";
    add_header Access-Control-Allow-Headers "Content-Type";
}
EOF

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
