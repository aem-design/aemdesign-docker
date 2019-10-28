#!/bin/bash

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
  export GPG_PUBID="50A036956AAC64C13EF47B10D1E96A30ECFC7DFF"
fi

if [[ -z "${GPG_PUBID_KEYGRIP}" ]]; then
  export GPG_PUBID_KEYGRIP="020E615868703482DC2CD110B98D2702B6ABF89C"
fi

git config --global gpg.program $(which gpg)
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
gpg-connect-agent reloadagent /bye
echo ">>> GET AGENT STATUS <<<"
gpg-agent
echo ">>> IMPORT KEYS <<<"
echo ${GPG_SECRET_KEYS} | base64 --decode | gpg --batch --import
echo ${GPG_OWNERTRUST} | base64 --decode | gpg --import-ownertrust
echo ">>> LIST KEYS <<<"
gpg --list-keys
echo ">>> CHECK KEYGRIP <<<"
gpg --with-keygrip -K ${GPG_PUBID}
echo ">>> CACHE PASSPHRASE <<<"
/usr/lib/gnupg/gpg-preset-passphrase --preset --passphrase ${GPG_PASSPHRASE} ${GPG_PUBID_KEYGRIP}
echo ">>> TEST GPG <<<"
echo "test" | gpg --clearsign

