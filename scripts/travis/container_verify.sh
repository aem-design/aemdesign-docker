#!/usr/bin/env bash

# requires that get_config.sh has been executed.

# to test this script run
# IMAGE="aemdesign/oracle-jdk" IMAGE_VERSION="jdk8" TEST_COMMAND_VERIFY="1.8" TEST_COMMAND="java -version 2>&1 | grep 'java version' | sed -e 's/.*java version \"\(.*\)\".*/\1/'"  ./container_verify.sh

if [[ -z "${IMAGE}" ]] || [[ -z "${IMAGE_VERSION}" ]] || [[ -z "${TEST_COMMAND}" ]] || [[ -z "${TEST_COMMAND_VERIFY}" ]]; then
    echo "please run get_config.sh"
    travis_terminate 1
fi

echo ">>> VERIFY BUILD CONTAINER <<<"
DIR=$(mktemp -d)
echo ${TEST_COMMAND}>"${DIR}/verify.bash"
echo "TEST:docker run -v ${DIR}:/verify ${IMAGE}:${IMAGE_VERSION} bash -c \"chmod u+x /verify/verify.bash; ./verify/verify.bash\""
export CONTAINER_OUTPUT=$(docker run -v ${DIR}:/verify ${IMAGE}:${IMAGE_VERSION} bash -c "cp /verify/verify.bash /; chmod u+x /verify.bash; ./verify.bash")
echo "CONTAINER_OUTPUT=${CONTAINER_OUTPUT}"

if [[ ! ${CONTAINER_OUTPUT} =~ ${TEST_COMMAND_VERIFY} ]]; then
    echo ">>> TEST FAILED <<<"
    echo "Expected: ${TEST_COMMAND_VERIFY}"
    echo "Got: ${CONTAINER_OUTPUT}"
    travis_terminate 1;
fi
