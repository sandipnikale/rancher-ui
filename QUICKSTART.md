# 🚀 Quick Reference - Deploy to GitHub Pages

## One-Command Deploy

```bash
cd /Users/sandip/longhorn/longhorn/rancher-support-ui
./setup-github-pages.sh
```

## Manual Deploy (3 Steps)

### 1. Push to GitHub
```bash
git init
git add .
git commit -m "Deploy Rancher Support UI Extension"
git remote add origin https://github.com/YOUR_USERNAME/rancher-support-ui.git
git branch -M main
git push -u origin main
```

### 2. Enable GitHub Pages
- Go to: **Settings → Pages**
- Source: **GitHub Actions**
- Wait for deployment (check **Actions** tab)

### 3. Install in Rancher
**URL**: `https://YOUR_USERNAME.github.io/rancher-support-ui/rancher-support-ui-0.1.0/package.json`

**Steps**:
1. Rancher: **☰ → Extensions → Available**
2. Click **⋮ → Manage Repositories → Create**
3. Name: `rancher-support-ui`
4. Paste URL above
5. Click **Create**
6. Find extension → **Install** → **Enable**

## Files Created

✅ `.github/workflows/deploy.yml` - Auto-build and deploy  
✅ `index.html` - Professional landing page  
✅ `setup-github-pages.sh` - Automated setup script  
✅ `GITHUB_PAGES_DEPLOYMENT.md` - Full documentation  

## Verify Deployment

```bash
# Check landing page
open https://YOUR_USERNAME.github.io/rancher-support-ui/

# Test package.json
curl https://YOUR_USERNAME.github.io/rancher-support-ui/rancher-support-ui-0.1.0/package.json
```

## Troubleshooting

**GitHub Actions fails?**
- Check: Settings → Actions → General
- Enable: "Read and write permissions"

**Extension not loading?**
- Verify: package.json URL is accessible
- Check: GitHub Pages is enabled and deployed

**Need help?**
- See: `GITHUB_PAGES_DEPLOYMENT.md` for detailed guide
