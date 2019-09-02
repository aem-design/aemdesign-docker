#Makefile for building a default aem docker image and running as a container

#defaults
name=aem65
port=4502

.PHONY: build run

build:
    cd centos-tini && \
    docker build -t aemdesign/centos-tini:latest. && \
    cd ../oracle-jdk && \
    docker build -t aemdesign/oracle-jdk:latest . && \
    cd ../java-ffmpeg && \
    docker build -t aemdesign/java-ffmpeg:latest . && \
    cd ../aem-base && \
    docker build -t aemdesign/aem-base:latest . && \
    cd ../aem && \
    docker build -t aemdesign/aem:latest . && \
    cd ../dispatcher && \
    docker build -t aemdesign/dispatcher:latest .

run:
	docker run --name $(name) \
	 -p$(port):8080 -d \
	 -v ~/aemdesign-docker/$(name)/crx-quickstart/repository:/aem/crx-quickstart/repository \
	 -v ~/aemdesign-docker/$(name)/crx-quickstart/logs:/aem/crx-quickstart/logs \
	 aemdesign/aem

default: build

