#!/data/data/com.termux/files/usr/bin/bash

# === TRUE GOD MODE: Static HTML Deployment for edudeals ===
GH_TOKEN="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"
USER="studentverify"
REPO="edudeals"
BRANCH="gh-pages"
CUSTOM_DOMAIN="studentverify.college"
DIST_DIR="dist"

echo "🚀 GOD MODE: Deploying static HTML site to $USER/$REPO ..."

# 1️⃣ Ensure Git remote
if [ ! -d ".git" ]; then
  echo "🔹 Initializing git..."
  git init
  git branch -M main
  git remote add origin https://$GH_TOKEN@github.com/$USER/$REPO.git
else
  echo "✅ Git repo already initialized."
  git remote set-url origin https://$GH_TOKEN@github.com/$USER/$REPO.git
fi

# 2️⃣ Clean dist folder
rm -rf $DIST_DIR
mkdir $DIST_DIR

# 3️⃣ Generate static site
cat > $DIST_DIR/index.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>StudentVerify - SheerID Student Discount Verification Service</title>
  <meta name="description" content="Professional SheerID student discount verification service. Get verified for exclusive student discounts in 24-48 hours." />
  <meta name="keywords" content="student discounts, SheerID verification, student deals, college discounts" />
  <link rel="icon" type="image/png" href="favicon.png" />
  <link rel="stylesheet" href="style.css" />
</head>
<body>
  <header>
    <h1>StudentVerify</h1>
    <p>Professional SheerID student discount verification service</p>
  </header>
  <main>
    <h2>Get Verified in 24-48 Hours</h2>
    <p>Access exclusive student discounts from top brands like Hulu, Autodesk, and The North Face.</p>
    <button onclick="alert('Verification process coming soon!')">Verify Now</button>
  </main>
  <footer>
    <p>&copy; 2025 StudentVerify. All rights reserved.</p>
  </footer>
  <script src="main.js"></script>
</body>
</html>
EOF

cat > $DIST_DIR/style.css <<'EOF'
body {
  font-family: Arial, sans-serif;
  text-align: center;
  background-color: #f9f9f9;
  color: #333;
}
header {
  background-color: #2563eb;
  color: white;
  padding: 20px 0;
}
button {
  background-color: #2563eb;
  color: white;
  padding: 10px 20px;
  border: none;
  cursor: pointer;
  font-size: 16px;
}
button:hover {
  background-color: #1e4db7;
}
footer {
  margin-top: 50px;
  font-size: 14px;
  color: #555;
}
EOF

cat > $DIST_DIR/main.js <<'EOF'
console.log('StudentVerify static site loaded successfully.');
EOF

# 4️⃣ Add CNAME
echo "$CUSTOM_DOMAIN" > $DIST_DIR/CNAME

# 5️⃣ Deploy to GitHub Pages
echo "🔹 Deploying to GitHub Pages..."
npx gh-pages -d $DIST_DIR -b $BRANCH -f

echo "✅ Deployment complete!"
echo "🌐 Live site: https://$CUSTOM_DOMAIN"
echo "🔹 Backup: https://studentverify.github.io/$REPO/"
