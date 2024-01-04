#FROM quay.io/cip-core-platform/nginx-116-centos7
FROM registry.access.redhat.com/ubi8/nginx-120:1-38

ENV SUMMARY="Source to image (s2i) builder image to generate static website using Hugo" \
    DESCRIPTION="Source to image (s2i) builder image to generate static website using Hugo"

ENV NAME=hugo \
    HUGO_VERSION=0.98.0 \
    NGINX_VERSION=1.20 \
    NGINX_SHORT_VER=120

LABEL summary="${SUMMARY}" \
      description="${DESCRIPTION}" \
      io.k8s.description="${DESCRIPTION}" \
      io.k8s.display-name="S2I Hugo ${HUGO_VERSION} on Nginx ${NGINX_VERSION}" \
      io.openshift.expose-services="8080:http,8443:https" \
      io.openshift.tags="builder,${NAME},rh-${NAME}${NGINX_SHORT_VER}" \
      com.redhat.component="rh-${NAME}${HUGO_VERSION}-container" \
      name="cip-core-platform/${NAME}-${HUGO_VERSION}-centos7" \
      version="${HUGO_VERSION}" \
      maintainer="CIP Maintainers <maintainers@sgcip.io>" \
      help="For more information visit https://github.com/sclorg/${NAME}-container" \
      usage="s2i build <SOURCE-REPOSITORY> centos7/${NAME}-${HUGO_VERSION}-centos7:latest <APP-NAME>"

USER root

RUN yum -y update && \
    yum -y install git && \
    yum clean all && \
    curl -sLO https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
    tar -zxvf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz -C /usr/local/bin && \
    rm -f hugo_${HUGO_VERSION}_Linux-64bit.tar.gz

# Copy extra files to the image.
COPY ./root/ /

# Copy custom s2i logic
COPY ./s2i/* $STI_SCRIPTS_PATH/

RUN chmod -R 755 $STI_SCRIPTS_PATH/

USER 1001
