#!/bin/bash

# Check if Java is installed
if ! command -v java &> /dev/null; then
    echo "Java is not installed. Installing Java..."
    # Execute the script to install Java
    sudo ./java.sh
else
    echo "Java is already installed."
    sudo java --version
fi

# Now proceed with installing Jenkins


# Add Jenkins repository
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian/jenkins.io-2023.key

# Add Jenkins repository to sources list
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package index
sudo apt update

# Install Jenkins
sudo apt install jenkins -y

# Start Jenkins service
sudo systemctl start jenkins

# Enable Jenkins service to start on boot
sudo systemctl enable jenkins

# Print Jenkins initial admin password
echo "Jenkins initial admin password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
