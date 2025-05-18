#!/bin/bash
# Update package lists
apt-get update -y

# Install Nginx
apt-get install nginx -y

# Start Nginx service
systemctl start nginx

# Enable Nginx to start on boot
systemctl enable nginx

# Optional: Add a custom homepage
echo "<h1>Welcome to Nginx on Ubuntu</h1>" > /var/www/html/index.nginx-debian.html
