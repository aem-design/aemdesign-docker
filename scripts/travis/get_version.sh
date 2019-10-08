#!/usr/bin/env bash

# Gets current version from Git log, need to have at least one tag for this to work
# create a tag that matches https://semver.org/

echo ">>> GET CONFIG FROM GIT <<<"
echo GET FULL GIT HISTORY
git fetch --unshallow --tags
export CURRENT_VERSION=$(git describe --tag --always --long | sed -e 's/\(.*\)-\(.*\)-.*/\1.\2/')
echo "CURRENT_VERSION:${CURRENT_VERSION}"
declare -a CURRENT_VERSION_ARRAY="(${CURRENT_VERSION//./ })";
export SEMVER_MAJOR=${CURRENT_VERSION_ARRAY[0]};
export SEMVER_MINOR=${CURRENT_VERSION_ARRAY[1]};
export SEMVER_PATCH=${CURRENT_VERSION_ARRAY[2]};
export SEMVER_BUILD=${CURRENT_VERSION_ARRAY[-1]}

# if tag already has MAJOR.MINOR.PATCH add git log commit count to patch
if [[ "${#CURRENT_VERSION_ARRAY[@]}" == "4" ]]; then
    echo "ADD PATCH TO BUILD VERSION"
    export SEMVER_BUILD=$(( ${SEMVER_PATCH} + ${SEMVER_BUILD} ))
fi

echo "SEMVER_MAJOR:${SEMVER_MAJOR}"
echo "SEMVER_MINOR:${SEMVER_MINOR}"
echo "SEMVER_BUILD:${SEMVER_BUILD}"

REGEX_NUMBER='^[0-9]+$'
if ! [[ $SEMVER_BUILD =~ $REGEX_NUMBER ]] ; then
    echo "SEMVER_BUILD is not number RESET to 0"
   SEMVER_BUILD=0
fi

export SEMVER=${SEMVER_MAJOR}.${SEMVER_MINOR}.${SEMVER_BUILD}
echo "SEMVER:${SEMVER}"
if [[ ${SEMVER_MAJOR} == "" ]];then
    echo PLEASE ADD TAG TO YOUR BRANCH
    travis_terminate 1;
fi
export TRAVIS_TAG=${SEMVER}
echo "TRAVIS_TAG:${TRAVIS_TAG}"
echo GIT_RELEASE_NOTES="$(git log $(git describe --tags --abbrev=0)..HEAD --pretty=format:"%h - %s (%an)")"
