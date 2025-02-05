#!/bin/sh

# Ensure Git is installed
apk add --no-cache git

# Clone repo if not present
if [ ! -d "/repo/.git" ]; then
    echo "Cloning repository..."
    git clone --depth=1 $REPO_URL /repo
else
    echo "Repository already exists. Watching for updates..."
fi

# Sync loop
while true; do
    cd /repo || exit
    git fetch origin
    LOCAL=$(git rev-parse HEAD)
    REMOTE=$(git rev-parse @{u})

    if [ "$LOCAL" != "$REMOTE" ]; then
        echo "Changes detected. Resetting and pulling latest..."
        git reset --hard origin/main
        git pull --force
    else
        echo "No changes detected."
    fi

    sleep $CHECK_INTERVAL
done

