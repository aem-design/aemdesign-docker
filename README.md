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
| aem                       |                   | [![build_status](https://travis-ci.org/aem-design/docker-aem.svg?branch=master)](https://travis-ci.org/aem-design/docker-aem) |
| aem-base                  | aem               | [![build_status](https://travis-ci.org/aem-design/docker-aem-base.svg?branch=master)](https://travis-ci.org/aem-design/docker-aem-base)  |
| ansible-playbook          |                   | [![build_status](https://travis-ci.org/aem-design/docker-ansible-playbook.svg?branch=master)](https://travis-ci.org/aem-design/docker-ansible-playbook)  |
| centos-java-buildpack     |                   | [![build_status](https://travis-ci.org/aem-design/docker-centos-java-buildpack.svg?branch=master)](https://travis-ci.org/aem-design/docker-centos-java-buildpack)  |
| centos-tini               | oracle-jdk dispatcher | [![build_status](https://travis-ci.org/aem-design/docker-centos-tini.svg?branch=master)](https://travis-ci.org/aem-design/docker-centos-tini)  |
| dispatcher                |                   | [![build_status](https://travis-ci.org/aem-design/docker-dispatcher.svg?branch=master)](https://travis-ci.org/aem-design/docker-dispatcher)  |
| dockerhub-description     |                   | [![build_status](https://travis-ci.org/aem-design/docker-dockerhub-description.svg?branch=master)](https://travis-ci.org/aem-design/docker-dockerhub-description)  |
| java-ffmpeg               | aem-base          | [![build_status](https://travis-ci.org/aem-design/docker-java-ffmpeg.svg?branch=master)](https://travis-ci.org/aem-design/docker-java-ffmpeg)  |
| jenkins                   |                   | [![build_status](https://travis-ci.org/aem-design/docker-jenkins.svg?branch=master)](https://travis-ci.org/aem-design/docker-jenkins)  |
| jenkins-base              | jenkins           | [![build_status](https://travis-ci.org/aem-design/docker-jenkins-base.svg?branch=master)](https://travis-ci.org/aem-design/docker-jenkins-base)  |
| nexus                     |                   | [![build_status](https://travis-ci.org/aem-design/docker-nexus.svg?branch=master)](https://travis-ci.org/aem-design/docker-nexus)  |
| nginx                |  | [![build_status](https://travis-ci.org/aem-design/docker-nginx.svg?branch=master)](https://travis-ci.org/aem-design/docker-nginx)  |
| oracle-jdk                | java-ffmpeg jenkins-base nexus | [![build_status](https://travis-ci.org/aem-design/docker-oracle-jdk.svg?branch=master)](https://travis-ci.org/aem-design/docker-oracle-jdk)  |
| openjdk                |  | [![build_status](https://travis-ci.org/aem-design/docker-openjdk.svg?branch=master)](https://travis-ci.org/aem-design/docker-openjdk)  |
| toughday                |  | [![build_status](https://travis-ci.org/aem-design/docker-toughday.svg?branch=master)](https://travis-ci.org/aem-design/docker-toughday)  |
| travis-build-trigger                |  | [![build_status](https://travis-ci.org/aem-design/docker-travis-build-trigger.svg?branch=master)](https://travis-ci.org/aem-design/docker-travis-build-trigger)  |
