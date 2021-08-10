
Set-Variable -Name "GPG_SECRET_KEYS" -Value ""

Write-Output ""
Write-Output ""
Write-Output "Test Ubuntu"
Write-Output ""
Write-Output ""

#docker run -it --rm -v ${PWD}:/build/source -v ${HOME}/.m2:/build/.m2 -e GPG_SECRET_KEYS=${GPG_SECRET_KEYS} -e GPG_OWNERTRUST -e GPG_PASSPHRASE -e GPG_PUBID -e GPG_PUBID_KEYGRIP --net=host ubuntu /bin/bash --login
docker run -it --rm -v ${PWD}:/build/source -v ${HOME}/.m2:/build/.m2 -e GPG_SECRET_KEYS=${GPG_SECRET_KEYS} -e GPG_OWNERTRUST -e GPG_PASSPHRASE -e GPG_PUBID -e GPG_PUBID_KEYGRIP --net=host ubuntu /bin/bash --login -c "apt-get update && apt-get install -y gpg && bash /build/source/setup-gpg.sh"

Write-Output ""
Write-Output ""
Write-Output "Test Centos"
Write-Output ""
Write-Output ""

docker run -it --rm -v ${PWD}:/build/source -v ${HOME}/.m2:/build/.m2 -e GPG_PRESET_EXECUTABLE=/usr/libexec/gpg-preset-passphrase -e GPG_SECRET_KEYS=${GPG_SECRET_KEYS} -e GPG_OWNERTRUST -e GPG_PASSPHRASE -e GPG_PUBID -e GPG_PUBID_KEYGRIP --net=host aemdesign/centos-java-buildpack:jdk8 /bin/bash --login -c "bash /build/source/setup-gpg.sh"
