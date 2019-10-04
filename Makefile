#Makefile for building a default aem docker image and running as a container

#defaults
name=aem65
port=4502

.PHONY: build run

build:
    cd docker-centos-tini && \
    docker build -t aemdesign/centos-tini:latest. && \
    cd ../docker-oracle-jdk && \
    docker build -t aemdesign/oracle-jdk:latest . && \
    cd ../docker-java-ffmpeg && \
    docker build -t aemdesign/java-ffmpeg:latest . && \
    cd ../docker-aem-base && \
    docker build -t aemdesign/aem-base:latest . && \
    cd ../docker-aem && \
    docker build -t aemdesign/aem:latest . && \
    cd ../docker-dispatcher && \
    docker build -t aemdesign/dispatcher:latest .

run:
	docker run --name $(name) \
	 -p$(port):8080 -d \
	 -v ~/aemdesign-docker/$(name)/crx-quickstart/repository:/aem/crx-quickstart/repository \
	 -v ~/aemdesign-docker/$(name)/crx-quickstart/logs:/aem/crx-quickstart/logs \
	 aemdesign/aem

default: build

