#!/bin/bash
# Update package lists
apt-get update -y

# Install Apache2
apt-get install apache2 -y

# Start Apache2 service
systemctl start apache2

# Enable Apache2 to start on boot
systemctl enable apache2

# Optional: Add a custom homepage
echo "<h1>Welcome to Apache on Ubuntu</h1>" > /var/www/html/index.html
