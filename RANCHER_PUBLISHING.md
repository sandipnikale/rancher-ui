# 📦 Publishing Rancher UI Extension via Extension Catalog Image (ECI)

This is the **official Rancher method** for publishing extensions.

## 🎯 Quick Start

### 1. Push to GitHub

```bash
cd /Users/sandip/longhorn/longhorn/rancher-support-ui

# Initialize git (if not done)
git init
git add .
git commit -m "Initial commit: Rancher Support UI Extension"

# Add your GitHub repository
git remote add origin https://github.com/YOUR_USERNAME/rancher-support-ui.git
git branch -M main
git push -u origin main
```

### 2. Create a GitHub Release

The extension will be automatically built and published when you create a **Tagged Release**.

**IMPORTANT**: The tag name MUST follow this format:
```
{package-name}-{version}
```

For this extension:
- Package name: `rancher-support-ui` (from package.json)
- Version: `0.1.0` (from package.json)
- **Tag name**: `rancher-support-ui-0.1.0`

#### Create Release via GitHub UI:

1. Go to your repository on GitHub
2. Click **Releases** → **Create a new release**
3. Click **Choose a tag**
4. Type: `rancher-support-ui-0.1.0`
5. Click **Create new tag: rancher-support-ui-0.1.0 on publish**
6. **Release title**: `v0.1.0` or `Rancher Support UI Extension v0.1.0`
7. **Description**: Add release notes
8. Click **Publish release**

#### Or create via command line:

```bash
# Create and push tag
git tag rancher-support-ui-0.1.0
git push origin rancher-support-ui-0.1.0

# Then create release on GitHub UI
```

### 3. Wait for Build

The GitHub Action will automatically:
1. Build the extension
2. Create an Extension Catalog Image
3. Push to GitHub Container Registry (ghcr.io)

Check progress: **Actions** tab in your repository

### 4. Install in Rancher

Once the build completes, install in Rancher:

#### Method 1: Via Repository (Recommended)

1. In Rancher UI: **☰ → Extensions → Available**
2. Click **⋮ (three dots)** → **Manage Repositories** → **Create**
3. Fill in:
   - **Name**: `rancher-support-ui`
   - **Index URL**: `https://ghcr.io/YOUR_USERNAME/rancher-support-ui`
4. Click **Create**
5. Go back to **Available** tab
6. Find "Rancher Support Bundle Manager"
7. Click **Install**
8. Click **Enable**

#### Method 2: Direct Installation

1. In Rancher UI: **☰ → Extensions → Available**
2. Click **⋮** → **Install Extension**
3. Enter: `ghcr.io/YOUR_USERNAME/rancher-support-ui:rancher-support-ui-0.1.0`
4. Click **Install**

## 📋 Version Updates

When you want to release a new version:

1. Update version in `package.json` (e.g., to `0.2.0`)
2. Update version in `pkg/rancher-support-ui/package.json`
3. Commit changes
4. Create new release with tag: `rancher-support-ui-0.2.0`

## 🔧 Workflow Details

The `.github/workflows/build-catalog.yml` workflow:
- Triggers on: Tagged releases
- Builds: Extension Catalog Image
- Publishes to: GitHub Container Registry (ghcr.io)
- Requires: GitHub token (automatically provided)

## 📚 Important Notes

### Package Naming
- Root `package.json` name: `rancher-support-ui`
- Extension `pkg/rancher-support-ui/package.json` name: `rancher-support-ui`
- ✅ Names match (required for workflow to work)

### Tag Naming Convention
- Format: `{package-name}-{version}`
- Example: `rancher-support-ui-0.1.0`
- ❌ Wrong: `v0.1.0`, `0.1.0`, `release-0.1.0`
- ✅ Correct: `rancher-support-ui-0.1.0`

### Registry
- Default: GitHub Container Registry (ghcr.io)
- Public: Anyone can install
- Private: Requires authentication

## 🐛 Troubleshooting

### Workflow Fails
- Check: Tag name matches `{package-name}-{version}` format
- Check: Package names in root and pkg match
- Check: GitHub Actions has write permissions

### Extension Not Appearing
- Wait: Build can take 5-10 minutes
- Check: Actions tab for build status
- Verify: Tag name is correct

### Can't Install in Rancher
- Check: Extension is published to ghcr.io
- Verify: Repository URL is correct
- Try: Direct installation method

## 📖 Official Documentation

https://extensions.rancher.io/extensions/next/publishing
