include Makehelp.mk

REPO_ROOT ?= $(shell git rev-parse --show-toplevel)
BUILD_DIR ?= $(dir $(realpath -s $(firstword $(MAKEFILE_LIST))))/build
VERSION ?= $(shell git describe --tags --always --dirty)

$(shell mkdir -p ${BUILD_DIR})

verify:
	${REPO_ROOT}/scripts/validate-charts.sh
	${REPO_ROOT}/scripts/lint-charts.sh
.PHONY: verify

version:
	@echo ${VERSION}

install-toolchain:
	${REPO_ROOT}/scripts/install-toolchain.sh

clean:
	rm -rf ${REPO_ROOT}/build/

