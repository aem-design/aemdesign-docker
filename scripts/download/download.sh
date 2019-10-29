#!/bin/bash

function downloadHelp() {
  echo "Usage:"
  echo "  ./download.sh {[FILE NAME PREFIX] [AUTH] [MODULE] [URL]}..."
  echo ""
  echo "  FILENAME_PREFIX:"
  echo "    - filename prefix to use, [-] = none"
  echo "  AUTH:"
  echo "    - auth to use, [-] = none"
  echo "  MODULE:"
  echo "    - module to use, [-] = none"
  echo "  URL:"
  echo "    - url to get"
}

function doDownload() {

  # get current script location
  local CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

  local FILENAME_PREFIX=${1?Need file name prefix}
  local FILEURL=${2?Need file url}
  local MODULE=${3:-}
  echo "download: $FILEURL"
  echo "module: $MODULE"

  local FILENAME=$(basename "$FILEURL")

  if [[ ! "$MODULE" == "" && ! "$MODULE" == "-" ]]; then
      MODULE_SCRIPT="${CURRENT_DIR}/$(echo $MODULE | sed -e 's/\(.*\):.*/\1/').py"
      echo "script: ${MODULE_SCRIPT}"

      if [[ ! -f "${MODULE_SCRIPT}" ]]; then
          echo "module: error, could not find module script"
          return
      fi

      FILTER=$(echo $MODULE | sed -e 's/.*:\(.*\)/\1/')
      echo "filter: ${FILTER}"
      echo "url: ${FILEURL}"
      FILEURL_FILTER_URL=$(${MODULE_SCRIPT} ${FILTER} ${FILEURL})
      echo "FILEURL_FILTER_URL:"
      echo ${FILEURL_FILTER_URL}
      if [[ "${FILEURL_FILTER_URL}" == "" ]]; then
          echo "module: error, could not get url from module"
          return
      fi
      FILENAME=$(basename "${FILEURL_FILTER_URL}")
      FILEURL=${FILEURL_FILTER_URL}
  fi

  echo "DOWNLOADING $FILEURL to ${FILENAME_PREFIX}${FILENAME}"
  curl \
  --connect-timeout 30 \
  --retry 300 \
  --retry-delay 5 \
  -L "${FILEURL}" -o ${FILENAME_PREFIX}${FILENAME}

}

function doDownloadAuth() {

  local FILENAME_PREFIX=${1?Need file name prefix}
  local BASICCREDS=${2?Need username password}
  local FILEURL=${3?Need file url}
  local MODULE=${4:-}
  echo "download: $FILEURL"
  echo "module: not supported"

  local FILENAME=$(basename "$FILEURL")

  echo "DOWNLOADING $FILENAME into ${FILENAME_PREFIX}${FILENAME}"
  curl \
  --connect-timeout 30 \
  --retry 300 \
  --retry-delay 5 \
  -A "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)" \
  -k \
  -u "${BASICCREDS}" -L "${FILEURL}" -o ${FILENAME_PREFIX}${FILENAME}

}


function download() {

  if [[ $# -eq 0 ]]; then
      downloadHelp
      return
  fi

  local ACTIONS_COUNT=$#
  local ACTIONS=($@)

  for (( i=0; i<=$ACTIONS_COUNT; i+=3 ))
    do

      local FILENAME_PREFIX=${ACTIONS[$i]}
      local AUTH=${ACTIONS[$(($i + 1))]}
      local FLAGS=${ACTIONS[$(($i + 2))]}
      local URL=${ACTIONS[$(($i + 3))]}

      if [[ ! $FILENAME_PREFIX == "" && ! $AUTH == "" && ! $URL == "" ]]; then

          if [[ $AUTH == "-" ]]; then
              doDownload "$FILENAME_PREFIX" "$URL" "$FLAGS"
          else
              doDownloadAuth "$FILENAME_PREFIX" "$AUTH" "$URL" "$FLAGS"
          fi

      fi

   done


}

