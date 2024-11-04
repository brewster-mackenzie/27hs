#!/bin/bash

# Load global variables
set -a
source ./global.sh

# Create a primary group for the project user
sudo groupadd -g $PROJECT_GID $PROJECT_USERNAME

# Create the project user
sudo useradd -m -u $PROJECT_UID -g $PROJECT_GID -s /bin/bash -G docker $PROJECT_USERNAME

# Create a network for the containers
docker network create --driver=bridge --subnet="$PROJECT_SUBNET" ${PROJECT_NAME}
