#!/usr/bin/env bash
set -euo pipefail

PLATFORM=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$([[ $(uname -m) = "x86_64" ]] && echo 'amd64' || echo 'arm64')
GIT_REPO_ROOT=$(git rev-parse --show-toplevel)
BUILD_DIR="${GIT_REPO_ROOT}/build"
TMP_DIR="${BUILD_DIR}/tmp"
TOOLS_DIR="${BUILD_DIR}/tools"
mkdir -p "${TOOLS_DIR}"
export PATH="${TOOLS_DIR}:${PATH}"

HELMV3_VERSION="v3.12.3"
KUBECTL_VERSION=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)

## Install kubectl
curl -sSL "https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/${PLATFORM}/${ARCH}/kubectl" -o "${TOOLS_DIR}/kubectl"
chmod +x "${TOOLS_DIR}/kubectl"

## Install kubeval
mkdir -p "${TMP_DIR}/kubeval"
curl -sSL https://github.com/instrumenta/kubeval/releases/latest/download/kubeval-${PLATFORM}-${ARCH}.tar.gz | tar xz -C "${TMP_DIR}/kubeval"
mv "${TMP_DIR}/kubeval/kubeval" "${TOOLS_DIR}/kubeval"

## Install helm v3
mkdir -p "${TMP_DIR}/helmv3"
curl -sSL https://get.helm.sh/helm-${HELMV3_VERSION}-${PLATFORM}-${ARCH}.tar.gz | tar xz -C "${TMP_DIR}/helmv3"
mv "${TMP_DIR}/helmv3/${PLATFORM}-${ARCH}/helm" "${TOOLS_DIR}/helmv3"
rm -rf "${PLATFORM}-${ARCH}"

rm -rf ${TMP_DIR}
