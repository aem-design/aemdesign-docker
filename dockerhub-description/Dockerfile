FROM    alpine

LABEL   os="centos 7" \
        container.description="push readme to docker hub" \
        version="1.0.0" \
        imagename="dockerhub-description" \
        test.command=" curl --version | awk 'NR==1 {print $3}'" \
        test.command.verify="7.29.0"

MAINTAINER  devops <devops@aem.design>

COPY dockerhub.sh /dockerhub.sh

ENTRYPOINT ["/dockerhub.sh"]
