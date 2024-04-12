install_docker_debian() {
    echo "Installing Docker on Debian-based distribution..."
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    # Add the repository to Apt sources:
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo usermod -aG docker ubuntu
}

# Function to install Docker on Red Hat-based distributions
install_docker_redhat() {
    echo "Installing Docker on Red Hat-based distribution..."
    sudo yum install docker -y
    sudo systemctl docker start
    sudo usermod -aG docker ec2-user
}

# Check for the presence of specific commands to determine the Linux distribution
if command -v apt &> /dev/null; then
    # Debian-based distributions (e.g., Ubuntu)
    install_docker_debian
elif command -v yum &> /dev/null; then
    # Red Hat-based distributions (e.g., CentOS, Fedora)
    install_docker_redhat
else
    # Unsupported distribution
    echo "Unsupported distribution. Java installation aborted."
    exit 1
fi

