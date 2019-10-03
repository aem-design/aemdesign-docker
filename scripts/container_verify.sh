#!/usr/bin/env bash

export CONTAINER_OUTPUT=$(docker run ${IMAGE}:${IMAGE_VERSION} ${TEST_COMMAND})
echo CONTAINER_OUTPUT=${CONTAINER_OUTPUT}
if [[ ! ${CONTAINER_OUTPUT} =~ ${TEST_COMMAND_VERIFY} ]]; then travis_terminate 1; fi
