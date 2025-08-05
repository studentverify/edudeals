#!/data/data/com.termux/files/usr/bin/bash

# === SAFE REAL DEPLOY SCRIPT (No PAT in file) ===
USER="studentverify"
REPO="edudeals"
BRANCH="gh-pages"
CUSTOM_DOMAIN="studentverify.college"
DIST_DIR="dist"

if [ -z "$GH_TOKEN" ]; then
  echo "❌ ERROR: GH_TOKEN is not set. Run: export GH_TOKEN=your_token"
  exit 1
fi

echo "🚀 Deploying REAL StudentVerify HTML site to $USER/$REPO ..."

# 1️⃣ Make sure git is ready
if [ ! -d ".git" ]; then
  git init
  git branch -M main
  git remote add origin https://$GH_TOKEN@github.com/$USER/$REPO.git
else
  git remote set-url origin https://$GH_TOKEN@github.com/$USER/$REPO.git
fi

# 2️⃣ Clean old dist and copy files (exclude dist itself)
rm -rf $DIST_DIR
mkdir $DIST_DIR
shopt -s extglob
cp -r !(dist) $DIST_DIR/

# 3️⃣ Add CNAME
echo "$CUSTOM_DOMAIN" > $DIST_DIR/CNAME

# 4️⃣ Deploy to GitHub Pages
echo "🔹 Deploying to GitHub Pages..."
npx gh-pages -d $DIST_DIR -b $BRANCH -f

echo "✅ Deployment complete!"
echo "🌐 Live site: https://$CUSTOM_DOMAIN"
echo "🔹 Backup: https://studentverify.github.io/$REPO/"
