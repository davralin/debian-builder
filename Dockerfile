FROM debian:sid-slim
MAINTAINER davralin

RUN \
  /usr/bin/apt-get -y update  && \
  /usr/bin/apt-get -y install git-core --no-install-recommends
