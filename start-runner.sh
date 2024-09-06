#!/bin/bash

export RUNNER_ALLOW_RUNASROOT="1"

REG_TOKEN=$(curl -sX POST -H "Authorization: token ${GH_TOKEN}" https://api.github.com/repos/${USERNAME}/${REPO}/actions/runners/registration-token | jq .token --raw-output)

cd /usr/local/bin/actions-runner

# TODO: Improve cleanup so it works when executing "docker-compose down"
cleanup() {
  if [ -e config.sh ]; then
    print_header "Removing GitHub Actions runner..."

    # If the agent has some running jobs, the configuration removal process will fail.
    # So, give it some time to finish the job.
    while true; do
      ./config.sh remove --token ${REG_TOKEN}

      echo "Retrying in 30 seconds..."
      sleep 30
    done
  fi
}

print_header() {
  lightcyan='\033[1;36m'
  nocolor='\033[0m'
  echo -e "${lightcyan}$1${nocolor}"
}

./config.sh --url https://github.com/${USERNAME}/${REPO} --token ${REG_TOKEN} --labels ${TAGS}

trap 'cleanup; exit 0' EXIT
trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!