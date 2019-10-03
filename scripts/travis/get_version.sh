#!/usr/bin/env bash

echo ">>> GET CONFIG FROM GIT <<<"
export CURRENT_VERSION=$(git describe --tag --always --long | sed -e 's/\(.*\)-\(.*\)-.*/\1.\2/')
declare -a CURRENT_VERSION_ARRAY="(${CURRENT_VERSION//./ })";
export SEMVER_MAJOR=${CURRENT_VERSION_ARRAY[0]};
export SEMVER_MINOR=${CURRENT_VERSION_ARRAY[1]};
export SEMVER_PATCH=${CURRENT_VERSION_ARRAY[2]};
export SEMVER_BUILD=${CURRENT_VERSION_ARRAY[-1]}
export SEMVER_BUILD=$(( ${SEMVER_PATCH} + ${SEMVER_BUILD} ))
echo "SEMVER_MAJOR:${SEMVER_MAJOR}"
echo "SEMVER_MINOR:${SEMVER_MINOR}"
echo "SEMVER_BUILD:${SEMVER_BUILD}"
export SEMVER=${SEMVER_MAJOR}.${SEMVER_MINOR}.${SEMVER_BUILD}
echo "SEMVER:${SEMVER}"
if [[ ${SEMVER_MAJOR} == "" ]];
    then travis_terminate 1;
fi
export TRAVIS_TAG=${SEMVER}
echo "TRAVIS_TAG:${TRAVIS_TAG}"
