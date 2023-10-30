#! /bin/bash

set -euo pipefail

RUNNER_USERNAME=${RUNNER_USERNAME:-ci}

TARGET_DIRECTORY=$HOME/actions-runner

mkdir -p ${TARGET_DIRECTORY}

(cd ${TARGET_DIRECTORY} && \
    curl -o actions-runner-linux-x64-2.310.2.tar.gz -L https://github.com/actions/runner/releases/download/v2.310.2/actions-runner-linux-x64-2.310.2.tar.gz &&\
    echo "fb28a1c3715e0a6c5051af0e6eeff9c255009e2eec6fb08bc2708277fbb49f93  actions-runner-linux-x64-2.310.2.tar.gz" | shasum -a 256 -c && \
    tar xzf ./actions-runner-linux-x64-2.310.2.tar.gz && rm ./actions-runner-linux-x64-2.310.2.tar.gz)

(cd ${TARGET_DIRECTORY} && \
  ./config.sh \
  --unattended --url "$REPO_URL" --token "$REGISTRATION_TOKEN" \
  --name "${RUNNER_NAME}" --labels "${RUNNER_TABLES:-vm}" --replace)

(cd ${TARGET_DIRECTORY} && sudo ./svc.sh install ${RUNNER_USERNAME} && sudo ./svc.sh start && sudo ./svc.sh status)
