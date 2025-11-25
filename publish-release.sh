#!/bin/bash

# Quick Publish Script for Rancher Extension
# This script helps you publish the extension using GitHub releases

set -e

echo "🚀 Rancher Extension Publishing Helper"
echo "========================================"
echo ""

# Get current version from package.json
VERSION=$(node -p "require('./package.json').version")
PACKAGE_NAME=$(node -p "require('./package.json').name")
TAG_NAME="${PACKAGE_NAME}-${VERSION}"

echo "📦 Package: ${PACKAGE_NAME}"
echo "🏷️  Version: ${VERSION}"
echo "🔖 Tag: ${TAG_NAME}"
echo ""

# Check if git is initialized
if [ ! -d .git ]; then
    echo "❌ Git repository not initialized"
    echo "Run: git init"
    exit 1
fi

# Check if remote is set
if ! git remote | grep -q origin; then
    echo "❌ No git remote 'origin' found"
    echo ""
    echo "Please add your GitHub repository:"
    echo "  git remote add origin https://github.com/YOUR_USERNAME/rancher-support-ui.git"
    exit 1
fi

# Check if there are uncommitted changes
if ! git diff-index --quiet HEAD --; then
    echo "⚠️  You have uncommitted changes"
    echo ""
    read -p "Do you want to commit them? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git add .
        read -p "Enter commit message: " COMMIT_MSG
        git commit -m "$COMMIT_MSG"
    else
        echo "Please commit your changes first"
        exit 1
    fi
fi

# Push to GitHub
echo ""
echo "📤 Pushing to GitHub..."
git push origin main || git push origin master

# Create and push tag
echo ""
echo "🏷️  Creating tag: ${TAG_NAME}"
git tag -a "${TAG_NAME}" -m "Release ${VERSION}"
git push origin "${TAG_NAME}"

echo ""
echo "✅ Tag pushed successfully!"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📋 Next Steps:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "1. Go to your GitHub repository"
echo "2. Click 'Releases' → 'Draft a new release'"
echo "3. Select tag: ${TAG_NAME}"
echo "4. Add release notes"
echo "5. Click 'Publish release'"
echo ""
echo "The GitHub Action will automatically build and publish"
echo "the Extension Catalog Image to ghcr.io"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📦 Installation in Rancher:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Repository URL:"
GITHUB_USER=$(git remote get-url origin | sed -n 's/.*github.com[:/]\([^/]*\)\/.*/\1/p')
echo "  https://ghcr.io/${GITHUB_USER}/${PACKAGE_NAME}"
echo ""
echo "Or direct install:"
echo "  ghcr.io/${GITHUB_USER}/${PACKAGE_NAME}:${TAG_NAME}"
echo ""
