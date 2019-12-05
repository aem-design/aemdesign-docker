#!/bin/bash

# NOTIFY AND ABORT IF MANDATORY PARAMS ARE NOT SET
if [[ -z "${GPG_SECRET_KEYS}" ]]; then
  echo "GPG_SECRET_KEYS is not set"
  exit 1
fi

if [[ -z "${GPG_OWNERTRUST}" ]]; then
  echo "GPG_OWNERTRUST is not set"
  exit 1
fi

if [[ -z "${GPG_PASSPHRASE}" ]]; then
  echo "GPG_PASSPHRASE is not set"
  exit 1
fi

if [[ -z "${GPG_PUBID}" ]]; then
  echo "GPG_PUBID is not set"
  exit 1
fi

if [[ -z "${GPG_PUBID_KEYGRIP}" ]]; then
  echo "GPG_PUBID_KEYGRIP is not set"
  exit 1
fi

# SET DEFAULTS
if [[ -z "${GPG_EXECUTABLE}" ]]; then
  export GPG_EXECUTABLE="gpg"
fi

if [[ -z "${GPG_PRESET_EXECUTABLE}" ]]; then
  export GPG_PRESET_EXECUTABLE="/usr/lib/gnupg/gpg-preset-passphrase"
fi

if [[ -z "${GPG_AGENT_EXECUTABLE}" ]]; then
  export GPG_AGENT_EXECUTABLE="gpg-agent"
fi

if [[ -z "${GPG_AGENT_CONNECT_EXECUTABLE}" ]]; then
  export GPG_AGENT_CONNECT_EXECUTABLE="gpg-connect-agent"
fi

${GPG_EXECUTABLE} --version

if [[ -f ${GPG_PRESET_EXECUTABLE} ]]; then
  ${GPG_PRESET_EXECUTABLE} --version
else
  echo "can't find ${GPG_PRESET_EXECUTABLE}"
  find / -name gpg-preset-passphrase
  exit 1
fi

git config --global gpg.program $(which ${GPG_EXECUTABLE})
mkdir ~/.gnupg
touch ~/.gnupg/gpg-agent.conf
echo "default-cache-ttl 600" > ~/.gnupg/gpg-agent.conf
echo "max-cache-ttl 7200" >> ~/.gnupg/gpg-agent.conf
echo "allow-preset-passphrase" >> ~/.gnupg/gpg-agent.conf
touch ~/.gnupg/gpg.conf
echo "auto-key-retrieve" >> ~/.gnupg/gpg.conf
echo "no-emit-version" >> ~/.gnupg/gpg.conf
echo "pinentry-mode loopback" >> ~/.gnupg/gpg.conf
echo "default-key ${GPG_PUBID}" >> ~/.gnupg/gpg.conf
cat ~/.gnupg/gpg.conf
echo ">>> UPDATE PERMISSIONS <<<"
# Set permissions to read, write, execute for only yourself, no others
chmod 700 ~/.gnupg
# Set permissions to read, write for only yourself, no others
chmod 600 ~/.gnupg/*
echo ">>> RESTART AGENT <<<"
${GPG_AGENT_CONNECT_EXECUTABLE} reloadagent /bye
echo ">>> GET AGENT STATUS <<<"
${GPG_AGENT_EXECUTABLE}
echo ">>> IMPORT KEYS <<<"
echo ${GPG_SECRET_KEYS} | base64 --decode | ${GPG_EXECUTABLE} --batch --import
echo ${GPG_OWNERTRUST} | base64 --decode | ${GPG_EXECUTABLE} --import-ownertrust
echo ">>> LIST KEYS <<<"
${GPG_EXECUTABLE} --list-secret-keys --keyid-format LONG
echo ">>> CHECK KEYGRIP <<<"
${GPG_EXECUTABLE} --with-keygrip -K ${GPG_PUBID}
echo ">>> CACHE PASSPHRASE <<<"
${GPG_PRESET_EXECUTABLE} --preset --passphrase ${GPG_PASSPHRASE} ${GPG_PUBID_KEYGRIP}
echo ">>> TEST GPG <<<"
${GPG_EXECUTABLE} --clearsign --batch ~/.gnupg/gpg.conf
cat ~/.gnupg/gpg.conf.asc

