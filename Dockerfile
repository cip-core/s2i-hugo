FROM nginx:1.16

ENV SUMMARY="Source to image (s2i) builder image to generate static website using Hugo" \
    DESCRIPTION="Source to image (s2i) builder image to generate static website using Hugo"

LABEL summary="$SUMMARY" \
       description="$DESCRIPTION" \
       io.openshift.s2i.scripts-url="image:///usr/libexec/s2i" \
       io.openshift.expose-services="8080:http,8443:https"

ENV HUGO_VERSION=0.59.1

USER root

RUN curl -sLO https://github.com/gohugoio/hugo/releases/download/v0.59.1/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
    tar -zxvf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz -C /usr/local/bin && \
    rm -f hugo_${HUGO_VERSION}_Linux-64bit.tar.gz

COPY ./s2i/* $STI_SCRIPTS_PATH/
RUN chmod -R 755 $STI_SCRIPTS_PATH/

USER 1001
