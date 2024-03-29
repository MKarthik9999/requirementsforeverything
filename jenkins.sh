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

install_jenkins_debian() {
    echo "Installing Jenkins on Debian-based distribution..."
    # Add Jenkins repository
    sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian/jenkins.io-2023.key

    # Add Jenkins repository to sources list
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
      https://pkg.jenkins.io/debian binary/ | sudo tee \
      /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt update
    sudo apt install jenkins -y
}

install_jenkins_redhat() {
    echo "Installing Jenkins on Red Hat-based distribution..."
    sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
    sudo yum upgrade -y
    sudo yum install jenkins -y
}

# Check for the presence of specific commands to determine the Linux distribution
if command -v apt &> /dev/null; then
    # Debian-based distributions (e.g., Ubuntu)
    install_jenkins_debian
elif command -v yum &> /dev/null; then
    # Red Hat-based distributions (e.g., CentOS, Fedora)
    install_jenkins_redhat
else
    # Unsupported distribution
    echo "Unsupported distribution. Java installation aborted."
    exit 1
fi

# Start Jenkins service
sudo systemctl start jenkins

# Enable Jenkins service to start on boot
sudo systemctl enable jenkins

# Print Jenkins initial admin password
echo "Jenkins initial admin password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
