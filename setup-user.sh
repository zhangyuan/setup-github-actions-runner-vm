#! /bin/bash

set -euo pipefail

RUNNER_USERNAME=${RUNNER_USERNAME:-ci}

adduser --disabled-password --gecos "" ${RUNNER_USERNAME}
usermod -aG sudo ${RUNNER_USERNAME}
usermod -aG docker ${RUNNER_USERNAME}

mkdir -p /etc/sudoers.d/
echo "${RUNNER_USERNAME} ALL=(ALL:ALL) NOPASSWD: ALL" >>  /etc/sudoers.d/${RUNNER_USERNAME}
