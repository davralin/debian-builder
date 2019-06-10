FROM debian:sid-slim
MAINTAINER davralin

RUN \
  /bin/echo "deb-src http://deb.debian.org/debian/ sid main" > /etc/apt/sources.list.d/src.list && \
  /usr/bin/apt-get -y update && \
  /usr/bin/apt-get -y install --no-install-recommends \
    blhc \
    build-essential \
    debhelper \
    devscripts \
    fakeroot \
    git-core \
    && \
    /bin/rm -rf /var/lib/apt/lists/*

COPY builder.sh /bin/builder.sh

ENTRYPOINT ["/bin/builder.sh"]
