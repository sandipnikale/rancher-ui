#!/bin/bash

# GitHub Pages Setup Script for Rancher Support UI Extension

set -e

echo "🚀 Setting up GitHub Pages deployment for Rancher Support UI Extension"
echo ""

# Check if git is initialized
if [ ! -d .git ]; then
    echo "📦 Initializing git repository..."
    git init
    git branch -M main
fi

# Check if remote exists
if ! git remote | grep -q origin; then
    echo ""
    echo "❓ Enter your GitHub repository URL (e.g., https://github.com/username/rancher-support-ui.git):"
    read REPO_URL
    git remote add origin "$REPO_URL"
    echo "✅ Remote 'origin' added"
else
    echo "✅ Git remote already configured"
fi

# Add all files
echo ""
echo "📝 Adding files to git..."
git add .

# Check if there are changes to commit
if git diff-index --quiet HEAD --; then
    echo "ℹ️  No changes to commit"
else
    echo "💾 Committing changes..."
    git commit -m "Setup GitHub Pages deployment for Rancher UI Extension"
fi

# Push to GitHub
echo ""
echo "📤 Pushing to GitHub..."
git push -u origin main

echo ""
echo "✅ Setup complete!"
echo ""
echo "📋 Next steps:"
echo "1. Go to your GitHub repository"
echo "2. Click Settings → Pages"
echo "3. Under 'Source', select 'GitHub Actions'"
echo "4. Wait for the workflow to complete (check Actions tab)"
echo "5. Your extension will be available at:"
echo "   https://YOUR_USERNAME.github.io/rancher-support-ui/"
echo ""
echo "📦 Installation URL for Rancher:"
echo "   https://YOUR_USERNAME.github.io/rancher-support-ui/rancher-support-ui-0.1.0/package.json"
echo ""
