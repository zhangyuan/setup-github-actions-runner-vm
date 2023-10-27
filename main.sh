#! /bin/bash

set -euo pipefail

export RUNNER_USERNAME=${RUNNER_USERNAME:-ci}

./install-depedencies.sh
./setup-user.sh
su -c /setup-runner.sh ${RUNNER_USERNAME}
