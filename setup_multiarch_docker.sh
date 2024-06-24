#!/bin/bash
# This script automatically installs docker if it's not already installed
# Then it brings in multi-arch support.

check_for_docker() {
    echo "Checking for docker"
    if command -v docker &> /dev/null
    then
        echo "Docker is installed."
        return 0
    else
        return 1
    fi
}


install_docker() {
    sudo apt-get remove docker docker-engine docker.io containerd runc -y

    sudo apt-get update
    sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y

    # Pull down the official docker GPG key
    curl -fsSl https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io -y

    echo "Docker should be properly installed now!"
}


setup_multi_arch() {
    echo "Setting up multi-arch support via qemu for docker!"
    sudo apt-get install qemu binfmt-support qemu-user-static

    docker run --rm --priviledged multiarch/qemu-user-static --reset -p yes

    docker run --rm --priviledged multiarch/qemu-user-static --reset

    
}


enable_docker() {
    echo "Setting up systemCTL stuff and configuring docker"

    sudo systemctl enable docker

    sudo systemctl start docker

    echo "Docker service started"
}


main() {
    if check_for_docker
    then
        echo "Skipping installation"
    else
        install_docker
        enable_docker
    fi

    setup_multi_arch

    echo "Docker is installed and configured for multi-arch."
}

main