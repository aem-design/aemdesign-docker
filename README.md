AEM Design - Docker Configuration
=================================

This project contains all of the docker images used for AEM.Design.

All images are published to hub.docker.com and are public.

Status of each submodule, some modules trigger other pipelines on success

## Docker - build and run docker locally
To build the necessary docker images required to run aem as a local docker image, from the root of `aemdesign-docker` run

```make```

Once completed, create a docker container which is running aem on port `4502`

```make run```

Confirm the container is running with `docker ps`

## Submodules



| Image                     | Pipeline Trigger  | Pipeline Status         |
|---------------------------|-------------------|-------------------------|
| aem                       |                   | [![build_status](https://travis-ci.org/aem-design/aem.svg?branch=master)](https://travis-ci.org/aem-design/aem) |
| aem-base                  | aem               | [![build_status](https://travis-ci.org/aem-design/aem-base.svg?branch=master)](https://travis-ci.org/aem-design/aem-base)  |
| ansible-playbook          |                   | [![build_status](https://travis-ci.org/aem-design/ansible-playbook.svg?branch=master)](https://travis-ci.org/aem-design/ansible-playbook)  |
| centos-java-buildpack     |                   | [![build_status](https://travis-ci.org/aem-design/centos-java-buildpack.svg?branch=master)](https://travis-ci.org/aem-design/centos-java-buildpack)  |
| centos-tini               | oracle-jdk dispatcher | [![build_status](https://travis-ci.org/aem-design/centos-tini.svg?branch=master)](https://travis-ci.org/aem-design/centos-tini)  |
| dispatcher                |                   | [![build_status](https://travis-ci.org/aem-design/dispatcher.svg?branch=master)](https://travis-ci.org/aem-design/dispatcher)  |
| dockerhub-description     |                   | [![build_status](https://travis-ci.org/aem-design/dockerhub-description.svg?branch=master)](https://travis-ci.org/aem-design/dockerhub-description)  |
| java-ffmpeg               | aem-base          | [![build_status](https://travis-ci.org/aem-design/java-ffmpeg.svg?branch=master)](https://travis-ci.org/aem-design/java-ffmpeg)  |
| jenkins                   |                   | [![build_status](https://travis-ci.org/aem-design/jenkins.svg?branch=master)](https://travis-ci.org/aem-design/jenkins)  |
| jenkins-base              | jenkins           | [![build_status](https://travis-ci.org/aem-design/jenkins-base.svg?branch=master)](https://travis-ci.org/aem-design/jenkins-base)  |
| nexus                     |                   | [![build_status](https://travis-ci.org/aem-design/nexus.svg?branch=master)](https://travis-ci.org/aem-design/nexus)  |
| oracle-jdk                | java-ffmpeg jenkins-base nexus | [![build_status](https://travis-ci.org/aem-design/oracle-jdk.svg?branch=master)](https://travis-ci.org/aem-design/oracle-jdk)  |
