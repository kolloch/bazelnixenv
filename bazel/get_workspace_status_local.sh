#!/usr/bin/env bash

set -euo pipefail

if ! which jq; then
  echo "Please install 'jq' with 'brew install jq' or 'apt install jq'" >&2
  exit 1
fi

echo "Getting workspace status..." >&2

if [ -z "${REMOTE:-}" ]; then
  if [ -n "${DOCKER_HOST:-}" ]; then
    echo DOCKER_HOST "$DOCKER_HOST"
  fi
  : "${DOCKER_CONFIG:=$HOME/.docker}"
  if [ -f "$DOCKER_CONFIG/config.json" ]; then
    echo "Found docker config at $DOCKER_CONFIG/config.json" >&2
    DOCKER_AUTH_CONFIG="$(jq -c . "$DOCKER_CONFIG/config.json" )"
  fi
  if [ -n "${DOCKER_AUTH_CONFIG:-}" ]; then
    echo DOCKER_AUTH_CONFIG "${DOCKER_AUTH_CONFIG//$'\n'/ }"
  fi
fi
