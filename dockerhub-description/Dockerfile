FROM    alpine

LABEL   os="centos 7" \
        container.description="push readme to docker hub" \
        version="1.0.0" \
        imagename="dockerhub-description"

MAINTAINER  devops <devops@aem.design>

COPY dockerhub.sh /dockerhub.sh

ENTRYPOINT ["/dockerhub.sh"]
