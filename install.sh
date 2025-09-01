#!/bin/bash

# Thorny boot splash
echo
echo
cat <<'EOF'
                                     ÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞ
                              ÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞ
                           ÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞ
                       ÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞ
                     ÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞ
                   ÞÞÞÞÞü      ÇÞÞÞ   ÞÏ       Þ6       ÞÞÞz   íÞÞÞÞÞz    ÞÞÞÞÞÞ
                  ÞÞÞÞÞÞ         ÞÇ   Þ        Ç        Þz       ÏÞ6        ÞÞÞÞÞÞ
                 ÞÞÞÞÞÞÞ    Þ{   ÞÇ   ÞÞzzz    ÞÞzzz    Þ    Þ    Þ    ÞÏ   ÞÞÞÞÞÞÞ
                ÞÞÞÞÞÞÞÞ    ÞÞ   ÞÇ   ÞÞÞÞÇ   ÏÞÞÞÞ6   ÏÞ    ÞÇ   Þ    Þü   ÞÞÞÞÞÞÞÞ
                ÞÞÞÞÞÞÞÞ    —    ÞÇ   ÞÞÞÞ    ÞÞÞÞÞ    ÞÞ    ÞÞÞÞÞÞ    Þ6   ÞÞÞÞÞÞÞÞ
                ÞÞÞÞÞÞÞÞ        ÏÞÇ   ÞÞÞ    ÞÞÞÞÞ    ÞÞÞ    ÞÞÞÞÞÞ    Þ6   ÞÞÞÞÞÞÞÞ
                ÞÞÞÞÞÞÞÞ    í   ÞÞÇ   ÞÞ    ÞÞÞÞÞ    ÇÞÞÞ    ÞÞ   Þ    Þ6   ÞÞÞÞÞÞÞÞ
                ÞÞÞÞÞÞÞÞ    Þ   ÇÞÇ   ÞÇ   —ÞÞÞÞ6    ÞÞÞÞ    ÞÏ   Þ    ÞÇ   ÞÞÞÞÞÞÞÞ
                 ÞÞÞÞÞÞÞ    Þ    ÞÇ   Þ        Þ        Þ{        Þ         ÞÞÞÞÞÞÞ
                  ÞÞÞÞÞÞ{   ÞÞ   üÞ   Þ        Þ        ÞÞü      ÞÞÞ›      ÞÞÞÞÞÞÞ
                    ÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞ
                      ÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞ
                        ÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞ
                           ÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞ
                               ÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞ
                                      ÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞÞ
EOF

echo
echo
echo
echo

echo
echo "╔══════════════════════════════════════════════╗"
echo "║   RIZZCO ENGINE: Rick Roll Search Engine     ║"
echo "║           All paths lead to rr.mp4           ║"
echo "╚══════════════════════════════════════════════╝"
echo

# Apache check
echo -n "🔍 Do you have Apache2 installed? (y/n): "
read apachecheck

if [ "$apachecheck" = "n" ]; then
    echo "📦 Installing Apache2..."
    sudo apt update
    sudo apt install apache2 -y
    echo "✅ Apache2 installed"
fi

# Ask for desired port
echo -n "🛠️ What port do you want to use for Rizzco Engine? "
read chosen_port

# Create web root
echo "🧱 Creating /var/www/rickengine"
sudo mkdir -p /var/www/rickengine
sudo chown -R $USER:$USER /var/www/rickengine
echo "✅ done"

# Copy payload files
echo "📦 Copying rr.mp4 → /var/www/rickengine"
cp rr.mp4 /var/www/rickengine/
echo "✅ done"

echo "📦 Copying .htaccess → /var/www/rickengine"
cp .htaccess /var/www/rickengine/
echo "✅ done"

# Generate Apache config with chosen port
echo "🧾 Generating Apache config for port $chosen_port"
cat <<EOF | sudo tee /etc/apache2/sites-available/rickengine.conf > /dev/null
Listen $chosen_port

<VirtualHost *:$chosen_port>
    ServerName rickengine.local
    DocumentRoot /var/www/rickengine

    <Directory /var/www/rickengine>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/rickengine_error.log
    CustomLog \${APACHE_LOG_DIR}/rickengine_access.log combined
</VirtualHost>
EOF
echo "✅ Config created"

# Enable site
echo "🔗 Linking site → /etc/apache2/sites-enabled"
sudo ln -s /etc/apache2/sites-available/rickengine.conf /etc/apache2/sites-enabled/rickengine.conf
echo "✅ done"

# Restart Apache
echo "🔄 Restarting Apache"
sudo systemctl restart apache2
echo "✅ done"

echo "🎉 Rizzco Engine: Port $chosen_port is now a portal."
echo "🌀 ENJOY THE VORTEX"
