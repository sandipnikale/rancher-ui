# Deploying Rancher Support UI Extension via GitHub Pages

## Quick Setup

### 1. Push to GitHub

```bash
cd /Users/sandip/longhorn/longhorn/rancher-support-ui

# Initialize git repository (if not already done)
git init

# Add all files
git add .

# Commit
git commit -m "Initial commit: Rancher Support UI Extension"

# Create repository on GitHub, then:
git remote add origin https://github.com/YOUR_USERNAME/rancher-support-ui.git
git branch -M main
git push -u origin main
```

### 2. Enable GitHub Pages

1. Go to your GitHub repository
2. Click **Settings** → **Pages**
3. Under **Source**, select **GitHub Actions**
4. The workflow will automatically run and deploy

### 3. Install in Rancher

Once deployed, your extension will be available at:
```
https://YOUR_USERNAME.github.io/rancher-support-ui/
```

**Installation URL for Rancher**:
```
https://YOUR_USERNAME.github.io/rancher-support-ui/rancher-support-ui-0.1.0/package.json
```

#### Steps in Rancher:
1. Navigate to **☰ → Extensions**
2. Click **Available** tab
3. Click **⋮ (three dots)** → **Manage Repositories** → **Create**
4. Enter:
   - **Name**: `rancher-support-ui`
   - **Index URL**: `https://YOUR_USERNAME.github.io/rancher-support-ui/rancher-support-ui-0.1.0/package.json`
5. Click **Create**
6. Go back to **Available** tab
7. Find "Rancher Support Bundle Manager"
8. Click **Install**
9. Click **Install** again to confirm
10. Once installed, click **Enable**

## Alternative: Manual Installation

If you prefer not to use GitHub Pages:

### Option 1: Direct File Upload
1. In Rancher: **☰ → Extensions → Available**
2. Click **Install from File**
3. Upload the entire `dist-pkg/rancher-support-ui-0.1.0/` directory as a zip file

### Option 2: Local Web Server
```bash
# Serve locally
cd dist-pkg
python3 -m http.server 8080
```

Then in Rancher, install from: `http://localhost:8080/rancher-support-ui-0.1.0/package.json`

## Troubleshooting

### GitHub Actions Fails
- Check that Node.js 16 is being used
- Verify all dependencies are in `package.json`
- Check workflow logs in **Actions** tab

### Extension Not Appearing in Rancher
- Verify the URL is accessible in a browser
- Check that `package.json` exists at the URL
- Ensure GitHub Pages is enabled and deployed
- Check browser console for CORS errors

### CORS Issues
The GitHub Actions workflow automatically sets up proper file structure. If you still have CORS issues:
- Ensure you're using the `package.json` URL, not the directory URL
- GitHub Pages should serve with correct headers by default

## Updating the Extension

To update after making changes:

```bash
# Make your changes to components
# ...

# Commit and push
git add .
git commit -m "Update extension"
git push

# GitHub Actions will automatically rebuild and redeploy
```

In Rancher, the extension should auto-update, or you can manually update from the Extensions page.

## Repository Structure for GitHub Pages

After deployment, your GitHub Pages will serve:
```
https://YOUR_USERNAME.github.io/rancher-support-ui/
├── index.html                                    # Landing page
└── rancher-support-ui-0.1.0/
    ├── package.json                              # Extension metadata (use this URL)
    ├── rancher-support-ui-0.1.0.umd.min.js      # Main bundle
    ├── rancher-support-ui-0.1.0.umd.min.*.js    # Component bundles
    └── ...                                       # Other assets
```

## Custom Domain (Optional)

To use a custom domain:
1. Add a `CNAME` file to the repository root with your domain
2. Configure DNS to point to GitHub Pages
3. Update the installation URL accordingly

## Security Notes

- GitHub Pages serves content over HTTPS automatically
- The extension is publicly accessible (suitable for open-source)
- For private extensions, consider using a private npm registry or Rancher's Helm chart approach
