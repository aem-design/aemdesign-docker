#!/usr/bin/env bash

# Gets current version from Git log, need to have at least one tag for this to work
# create a tag that matches https://semver.org/

echo ">>> GET CONFIG FROM GIT <<<"
echo GET FULL GIT HISTORY
git fetch --depth=10000 --tags
export CURRENT_VERSION=$(git describe --tag --always --long | sed -e 's/\(.*\)-\(.*\)-.*/\1.\2/')

echo "CURRENT_VERSION:${CURRENT_VERSION}"
declare -a CURRENT_VERSION_ARRAY="(${CURRENT_VERSION//./ })";
export SEMVER_MAJOR=${CURRENT_VERSION_ARRAY[0]};
echo ::set-env name=SEMVER_MAJOR::${SEMVER_MAJOR}
echo ::set-output name=SEMVER_MAJOR::${SEMVER_MAJOR}
export SEMVER_MINOR=${CURRENT_VERSION_ARRAY[1]};
echo ::set-env name=SEMVER_MINOR::${SEMVER_MINOR}
echo ::set-output name=SEMVER_MINOR::${SEMVER_MINOR}
export SEMVER_PATCH=${CURRENT_VERSION_ARRAY[2]};
echo ::set-env name=SEMVER_PATCH::${SEMVER_PATCH}
echo ::set-output name=SEMVER_PATCH::${SEMVER_PATCH}
export SEMVER_BUILD=${CURRENT_VERSION_ARRAY[-1]}
echo ::set-env name=SEMVER_BUILD::${SEMVER_BUILD}
echo ::set-output name=SEMVER_BUILD::${SEMVER_BUILD}

# if tag already has MAJOR.MINOR.PATCH add git log commit count to patch
if [[ "${#CURRENT_VERSION_ARRAY[@]}" == "4" ]]; then
    echo "ADD PATCH TO BUILD VERSION"
    export SEMVER_BUILD=$(( ${SEMVER_PATCH} + ${SEMVER_BUILD} ))
  echo ::set-env name=SEMVER_BUILD::${SEMVER_BUILD}
  echo ::set-output name=SEMVER_BUILD::${SEMVER_BUILD}
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
echo ::set-env name=SEMVER::${SEMVER}
echo ::set-output name=SEMVER::${SEMVER}
echo "SEMVER:${SEMVER}"
if [[ ${SEMVER_MAJOR} == "" ]];then
    echo PLEASE ADD TAG TO YOUR BRANCH
    exit 1;
fi
export GITHUB_TAG=${SEMVER}
echo ::set-env name=GITHUB_TAG::${GITHUB_TAG}
echo ::set-output name=GITHUB_TAG::${GITHUB_TAG}
echo "GITHUB_TAG:${GITHUB_TAG}"
export GIT_RELEASE_NOTES="$(git log $(git describe --tags --abbrev=0)..HEAD --pretty=format:"%h - %s (%an)<br>")"
echo ::set-env name=GIT_RELEASE_NOTES::${GIT_RELEASE_NOTES}
echo ::set-output name=GIT_RELEASE_NOTES::${GIT_RELEASE_NOTES}

#set CURRENT_VERSION to semver
echo ::set-env name=CURRENT_VERSION::${GITHUB_TAG}
echo ::set-output name=CURRENT_VERSION::${GITHUB_TAG}

#get current branch name
export GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo ::set-env name=GIT_BRANCH::${GIT_BRANCH}
echo ::set-output name=GIT_BRANCH::${GIT_BRANCH}
