## CentOS 7 with Dockerhub Readme Update Script

[![build_status](https://travis-ci.org/aem-design/dockerhub-description.svg?branch=master)](https://travis-ci.org/aem-design/dockerhub-description) 
[![github license](https://img.shields.io/github/license/aem-design/dockerhub-description)](https://github.com/aem-design/dockerhub-description) 
[![github issues](https://img.shields.io/github/issues/aem-design/dockerhub-description)](https://github.com/aem-design/dockerhub-description) 
[![github last commit](https://img.shields.io/github/last-commit/aem-design/dockerhub-description)](https://github.com/aem-design/dockerhub-description) 
[![github repo size](https://img.shields.io/github/repo-size/aem-design/dockerhub-description)](https://github.com/aem-design/dockerhub-description) 
[![docker stars](https://img.shields.io/docker/stars/aemdesign/dockerhub-description)](https://hub.docker.com/r/aemdesign/dockerhub-description) 
[![docker pulls](https://img.shields.io/docker/pulls/aemdesign/dockerhub-description)](https://hub.docker.com/r/aemdesign/dockerhub-description) 
[![github release](https://img.shields.io/github/release/aem-design/dockerhub-description)](https://github.com/aem-design/dockerhub-description)

This is docker image based on `alpine`

# Quick Upload to Github 

```bash
docker run --rm \
    -v $(pwd)/readme.md:/README.md \
    $DOCKERHUB_USERNAME \
    $DOCKERHUB_PASSWORD \
    $DOCKERHUB_REPO \
    aemdesign/dockerhub-description
```

## Script Parameters

This image uses environment variables for configuration.

|Available variables     |Default value        |Description                                         |
|------------------------|---------------------|----------------------------------------------------|
|`USERNAME`    | no default           | Username for admin of the repo |
|`PASSWORD`    | no default           | User password |
|`REPO` | no default | Full name of repo `Organisation/Name` |
|`README`   | `/data/README.md`           | Readme filename if diffrent|
|`API_URL`           |`https://hub.docker.com/v2`    | URL for dockerhub if diffrent|

## Mount the README.md

By default, if the `README` environment variable is not set, this image always pushes the file
`/data/README.md` as full description to Docker Hub.

For GitHub repositories you can use `-v /path/to/repository:/data/` or if in same directory `-v $(pwd):/data/`.

If your description is not named `README.md` mount the file directory using `-v /path/to/description.md:/data/README.md` or pass it as `README` parameter.
