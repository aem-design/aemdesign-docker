#!/usr/bin/env bash

#gets config from Dockerfile

if [[ -z "${ORGANISATION_NAME}" ]]; then
  echo "please set ORGANISATION_NAME variable"
fi

echo ">>> GET CONFIG FROM DOCKERFILE <<<"
export IMAGE_NAME=$(grep imagename= Dockerfile | sed -e 's/.*imagename="\(.*\)".*/\1/')
echo "IMAGE_NAME=${IMAGE_NAME}" >> $GITHUB_ENV
echo "IMAGE_NAME=${IMAGE_NAME}" >> $GITHUB_OUTPUT

export TEST_COMMAND=$(grep test.command= Dockerfile | sed -e 's/.*test.command="\(.*\)".*/\1/')
echo "TEST_COMMAND=${TEST_COMMAND}" >> $GITHUB_ENV
echo "TEST_COMMAND=${TEST_COMMAND}" >> $GITHUB_OUTPUT

export TEST_COMMAND_VERIFY=$(grep test.command.verify= Dockerfile | sed -e 's/.*test.command.verify="\(.*\)".*/\1/')
echo "TEST_COMMAND_VERIFY=${TEST_COMMAND_VERIFY}" >> $GITHUB_ENV
echo "TEST_COMMAND_VERIFY=${TEST_COMMAND_VERIFY}" >> $GITHUB_OUTPUT

export IMAGE_VERSION=$(grep version= Dockerfile | sed -e 's/.*version="\(.*\)".*/\1/')
echo "IMAGE_VERSION=${IMAGE_VERSION}" >> $GITHUB_ENV
echo "IMAGE_VERSION=${IMAGE_VERSION}" >> $GITHUB_OUTPUT

export IMAGE="${ORGANISATION_NAME}/${IMAGE_NAME}"
echo "IMAGE=${IMAGE}" >> $GITHUB_ENV
echo "IMAGE=${IMAGE}}" >> $GITHUB_OUTPUT

echo "IMAGE_NAME=${IMAGE_NAME}"
echo "IMAGE_VERSION=${IMAGE_VERSION}"
echo "TEST_COMMAND=${TEST_COMMAND}"
echo "TEST_COMMAND_VERIFY=${TEST_COMMAND_VERIFY}"

