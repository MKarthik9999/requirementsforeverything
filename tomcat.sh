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

# Now proceed with installing Tomcat

install_Tomcat_debian() {
    echo "Installing Tomcat on Debian-based distribution..."
    
    sudo apt update -y
    sudo wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.19/bin/apache-tomcat-10.1.19.tar.gz
    sudo tar xvzf apache-tomcat-10.1.19.tar.gz
    sudo rm -rf apache-tomcat-10.1.19.tar.gz
    sudo mv apache-tomcat-10.1.19/ /opt/tomcat
    # creating linked files for tomcat startup.sh and shutdown.sh so that we can access them anywhere from the system rather
    # than coming and accessing only from the folder
    sudo ln -s /opt/tomcat/bin/startup.sh /usr/local/bin/starttomcat
    sudo ln -s /opt/tomcat/bin/shutdown.sh /usr/local/bin/stoptomcat
    sudo cd ~
}

install_Tomcat_redhat() {
    echo "Installing Tomcat on Red Hat-based distribution..."
    sudo yum update -y
    sudo cd /opt/
    sudo wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.19/bin/apache-tomcat-10.1.19.tar.gz
    sudo tar xvzf apache-tomcat-10.1.19.tar.gz
    sudo rm -rf apache-tomcat-10.1.19.tar.gz
    sudo mv apache-tomcat-10.1.19/ /opt/tomcat
    # creating linked files for tomcat startup.sh and shutdown.sh so that we can access them anywhere from the system rather 
    # than coming and accessing only from the folder
    sudo ln -s /opt/tomcat/bin/startup.sh /usr/local/bin/starttomcat
    sudo ln -s /opt/tomcat/bin/shutdown.sh /usr/local/bin/stoptomcat
    sudo cd ~

}

# Check for the presence of specific commands to determine the Linux distribution
if command -v apt &> /dev/null; then
    # Debian-based distributions (e.g., Ubuntu)
    install_Tomcat_debian
elif command -v yum &> /dev/null; then
    # Red Hat-based distributions (e.g., CentOS, Fedora)
    install_Tomcat_redhat
else
    # Unsupported distribution
    echo "Unsupported distribution. Java installation aborted."
    exit 1
fi

