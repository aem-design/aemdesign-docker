#!/usr/bin/env bash

#gets config from Dockerfile

if [[ -z "${ORGANISATION_NAME}" ]]; then
  echo "please set ORGANISATION_NAME variable"
fi

echo ">>> GET CONFIG FROM DOCKERFILE <<<"
export IMAGE_NAME=$(grep imagename= Dockerfile | sed -e 's/.*imagename="\(.*\)".*/\1/')
echo ::set-env name=IMAGE_NAME::${IMAGE_NAME}
echo ::set-output name=IMAGE_NAME::${IMAGE_NAME}
export TEST_COMMAND=$(grep test.command= Dockerfile | sed -e 's/.*test.command="\(.*\)".*/\1/')
echo ::set-env name=TEST_COMMAND::${TEST_COMMAND}
echo ::set-output name=TEST_COMMAND::${TEST_COMMAND}
export TEST_COMMAND_VERIFY=$(grep test.command.verify= Dockerfile | sed -e 's/.*test.command.verify="\(.*\)".*/\1/')
echo ::set-env name=TEST_COMMAND_VERIFY::${TEST_COMMAND_VERIFY}
echo ::set-output name=TEST_COMMAND_VERIFY::${TEST_COMMAND_VERIFY}
export IMAGE_VERSION=$(grep version= Dockerfile | sed -e 's/.*version="\(.*\)".*/\1/')
echo ::set-env name=IMAGE_VERSION::${IMAGE_VERSION}
echo ::set-output name=IMAGE_VERSION::${IMAGE_VERSION}
export IMAGE="${ORGANISATION_NAME}/${IMAGE_NAME}"
echo ::set-env name=IMAGE::${IMAGE}
echo ::set-output name=IMAGE::${IMAGE}
echo "IMAGE_NAME=${IMAGE_NAME}"
echo "IMAGE_VERSION=${IMAGE_VERSION}"
echo "TEST_COMMAND=${TEST_COMMAND}"
echo "TEST_COMMAND_VERIFY=${TEST_COMMAND_VERIFY}"

