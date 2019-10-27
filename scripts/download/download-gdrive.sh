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

  curl -c ./tmp/cookie -s -L "https://drive.google.com/uc?export=download&id=${FILEID}" > /dev/null
  curl -Lb ./tmp/cookie "https://drive.google.com/uc?export=download&confirm=`awk '/download/ {print $NF}' ./tmp/cookie`&id=${FILEID}" -o ${FILENAME}

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

