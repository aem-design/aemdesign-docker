#!/usr/bin/env bash

# requires that get_config.sh has been executed, will

# to test this script run
# IMAGE="aemdesign/oracle-jdk" IMAGE_VERSION="jdk8" TEST_COMMAND_VERIFY="1.8" TEST_COMMAND="java -version 2>&1 | grep 'java version' | sed -e 's/.*java version \"\(.*\)\".*/\1/'"  ./container_verify.sh

if [[ -z "${IMAGE}" ]] || [[ -z "${IMAGE_VERSION}" ]] || [[ -z "${TEST_COMMAND}" ]] || [[ -z "${TEST_COMMAND_VERIFY}" ]]; then
    echo "please run github_get_config.sh"
    echo "source <(curl -sL https://github.com/aem-design/aemdesign-docker/releases/latest/download/github_get_config.sh)"
    exit 1
fi

#create a verify script and copy it into the container
echo ">>> VERIFY BUILD CONTAINER <<<"
DIR=$(mktemp -d)
echo "TEST_COMMAND:${TEST_COMMAND}"
echo "TEST:docker run --env TEST_COMMAND ${IMAGE}:${IMAGE_VERSION} bash -c 'eval \${TEST_COMMAND} 2>&1 | grep -q -e ${TEST_COMMAND_VERIFY} && echo true || echo false'"
export CONTAINER_OUTPUT=$(docker run --env TEST_COMMAND ${IMAGE}:${IMAGE_VERSION} bash -c "eval \${TEST_COMMAND} 2>&1 | grep -q -e \"${TEST_COMMAND_VERIFY}\" && echo true || echo false")
echo "CONTAINER_OUTPUT=${CONTAINER_OUTPUT}" >> $GITHUB_ENV
echo ::set-output name=CONTAINER_OUTPUT::$CONTAINER_OUTPUT
echo "CONTAINER_OUTPUT:${CONTAINER_OUTPUT}"
echo "TEST IF OUTPUT MATCHES EXPECTED"
if [[ "${CONTAINER_OUTPUT}" != "true" ]]; then
    echo ">>> TEST FAILED <<<"
    echo "Expected: ${TEST_COMMAND_VERIFY}"
    echo "Got: ${CONTAINER_OUTPUT}"
    exit 1
fi
