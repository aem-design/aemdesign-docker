#!/bin/bash

function downloadGDriveHelp() {
  echo "Usage:"
  echo "  ./gdrive.sh [ACTION] [FILE ID] [FILE NAME]"
  echo ""
  echo "  ACTIONS"
  echo "    - download"
}

function doDownloadGDrive() {

  local FILEID=${1?Need file id}
  local FILENAME=${2?Need file name}
  echo "download: $FILEID"

  if [[ ! -d tmp ]]; then
      echo "Creating temp folder"
      mkdir tmp
  fi

  local URL_COOKIE="https://drive.google.com/uc?export=download&id=${FILEID}"
#  echo "COOKIE URL ${URL_COOKIE}"
  curl -c ./tmp/cookie -s -L "${URL_COOKIE}" > /dev/null
  COOKIE_CONFIRM=$(awk '/download/ {print $NF}' ./tmp/cookie)
  cat ./tmp/cookie
#  echo "COOKIE_CONFIRM: ${COOKIE_CONFIRM}"

  if [[ "" == "${COOKIE_CONFIRM}" ]]; then
    COOKIE_CONFIRM="t"
  fi

  local URL_DOWNLOAD="https://drive.usercontent.google.com/download?export=download&&authuser=0&confirm=${COOKIE_CONFIRM}&id=${FILEID}"
#  echo "DOWNLOADING ${URL_DOWNLOAD} to ${FILENAME}"
  curl -Lb ./tmp/cookie "${URL_DOWNLOAD}" -o ${FILENAME}

}

function downloadGDrive() {
  local ACTION=${1?Need action}
  local FILEID=${2?Need file id}
  local FILENAME=${3?Need file name}

  case $ACTION in
  download)
    doDownloadGDrive "$FILEID" "$FILENAME"
    ;;
  *)
    downloadGDriveHelp
    ;;
  esac


}

