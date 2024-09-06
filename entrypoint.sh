#!/bin/bash

# Start docker
start-docker.sh

# Start GitHub Runner
echo -ne '\n' | start-runner.sh

# Execute specified command
"$@"