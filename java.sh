#!/bin/bash

# Function to install Java on Debian-based distributions
install_java_debian() {
    echo "Installing Java on Debian-based distribution..."
    sudo apt update
    sudo apt install fontconfig openjdk-17-jre -y
}

# Function to install Java on Red Hat-based distributions
install_java_redhat() {
    echo "Installing Java on Red Hat-based distribution..."
    sudo amazon-linux-extras enable corretto8
    sudo yum install java-17-amazon-corretto-devel -y  #openjdk-17

    # Uncomment below line if you want to install OpenJDK 11
    # sudo yum install -y java-11-openjdk-devel
}

# Check for the presence of specific commands to determine the Linux distribution
if command -v apt &> /dev/null; then
    # Debian-based distributions (e.g., Ubuntu)
    install_java_debian
elif command -v yum &> /dev/null; then
    # Red Hat-based distributions (e.g., CentOS, Fedora)
    install_java_redhat
else
    # Unsupported distribution
    echo "Unsupported distribution. Java installation aborted."
    exit 1
fi

