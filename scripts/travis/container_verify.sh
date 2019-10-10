#!/usr/bin/env bash

# requires that get_config.sh has been executed, will

# to test this script run
# IMAGE="aemdesign/oracle-jdk" IMAGE_VERSION="jdk8" TEST_COMMAND_VERIFY="1.8" TEST_COMMAND="java -version 2>&1 | grep 'java version' | sed -e 's/.*java version \"\(.*\)\".*/\1/'"  ./container_verify.sh

if [[ -z "${IMAGE}" ]] || [[ -z "${IMAGE_VERSION}" ]] || [[ -z "${TEST_COMMAND}" ]] || [[ -z "${TEST_COMMAND_VERIFY}" ]]; then
    echo "please run get_config.sh"
    travis_terminate 1
fi

#create a verify script and copy it into the container
echo ">>> VERIFY BUILD CONTAINER <<<"
DIR=$(mktemp -d)
echo "TEST_COMMAND:${TEST_COMMAND}"
echo "TEST:docker run --env TEST_COMMAND ${IMAGE}:${IMAGE_VERSION} bash -c '\$(\${TEST_COMMAND})'"
export CONTAINER_OUTPUT=$(docker run --env TEST_COMMAND ${IMAGE}:${IMAGE_VERSION} bash -c "\$(\${TEST_COMMAND})")
echo "CONTAINER_OUTPUT:${CONTAINER_OUTPUT}"

if [[ "${CONTAINER_OUTPUT}" != *"${TEST_COMMAND_VERIFY}"* ]]; then
    echo ">>> TEST FAILED <<<"
    echo "Expected: ${TEST_COMMAND_VERIFY}"
    echo "Got: ${CONTAINER_OUTPUT}"
    travis_terminate 1
fi
