#!/usr/bin/env bash

DOCKER_FILE=${1?Need docker file as source}

echo ">>> GET CONFIG FROM DOCKERFILE <<<"
export IMAGE_NAME=$(grep imagename= "${DOCKER_FILE}" | sed -e 's/.*imagename="\(.*\)".*/\1/')
export TEST_COMMAND=$(grep test.command= "${DOCKER_FILE}" | sed -e 's/.*test.command="\(.*\)".*/\1/')
export TEST_COMMAND_VERIFY=$(grep test.command.verify= "${DOCKER_FILE}" | sed -e 's/.*test.command.verify="\(.*\)".*/\1/')
export IMAGE_VERSION=$(grep version= "${DOCKER_FILE}" | sed -e 's/.*version="\(.*\)".*/\1/')
export IMAGE="${ORGANISATION_NAME}/${IMAGE_NAME}"
echo "IMAGE_NAME=${IMAGE_NAME}"
echo "IMAGE_VERSION=${IMAGE_VERSION}"
echo "TEST_COMMAND=${TEST_COMMAND}"
echo "TEST_COMMAND_VERIFY=${TEST_COMMAND_VERIFY}"

