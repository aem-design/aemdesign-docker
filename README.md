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
| aem                       |                   | [![pipeline status](https://gitlab.com/aem.design/aem/badges/master/pipeline.svg)](https://gitlab.com/aem.design/aem/commits/master) |
| aem-base                  | aem               | [![pipeline status](https://gitlab.com/aem.design/aem-base/badges/master/pipeline.svg)](https://gitlab.com/aem.design/aem-base/commits/master) |
| ansible-playbook          |                   | [![pipeline status](https://gitlab.com/aem.design/ansible-playbook/badges/master/pipeline.svg)](https://gitlab.com/aem.design/ansible-playbook/commits/master) |
| centos-java-buildpack     |                   | [![pipeline status](https://gitlab.com/aem.design/centos-java-buildpack/badges/master/pipeline.svg)](https://gitlab.com/aem.design/centos-java-buildpack/commits/master) |
| centos-tini               | oracle-jdk dispatcher | [![pipeline status](https://gitlab.com/aem.design/centos-tini/badges/master/pipeline.svg)](https://gitlab.com/aem.design/centos-tini/commits/master) |
| dispatcher                |                   | [![pipeline status](https://gitlab.com/aem.design/dispatcher/badges/master/pipeline.svg)](https://gitlab.com/aem.design/dispatcher/commits/master) |
| java-ffmpeg               | aem-base          | [![pipeline status](https://gitlab.com/aem.design/java-ffmpeg/badges/master/pipeline.svg)](https://gitlab.com/aem.design/java-ffmpeg/commits/master) |
| jenkins                   |                   | [![pipeline status](https://gitlab.com/aem.design/jenkins/badges/master/pipeline.svg)](https://gitlab.com/aem.design/jenkins/commits/master) |
| jenkins-base              | jenkins           | [![pipeline status](https://gitlab.com/aem.design/jenkins-base/badges/master/pipeline.svg)](https://gitlab.com/aem.design/jenkins-base/commits/master) |
| nexus                     |                   | [![pipeline status](https://gitlab.com/aem.design/nexus/badges/master/pipeline.svg)](https://gitlab.com/aem.design/nexus/commits/master) |
| oracle-jdk                | java-ffmpeg jenkins-base nexus | [![pipeline status](https://gitlab.com/aem.design/oracle-jdk/badges/master/pipeline.svg)](https://gitlab.com/aem.design/oracle-jdk/commits/master) |
