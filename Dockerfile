FROM golang
MAINTAINER Alvaro Morales <alvarom@mit.edu>

# install dependencies
RUN apt-get update && \
  apt-get install -y git-core

# setup project structure
RUN mkdir -p $GOPATH/src/github.com/influxdb && \
  cd $GOPATH/src/github.com/influxdb && \
  git clone https://github.com/influxdb/influxdb.git

ADD build.sh /build.sh
RUN chmod +x /build.sh
RUN /build.sh

# build & install
RUN mkdir -p /opt/influxdb/ && \
  ln -s $GOPATH/bin/influx /opt/influxdb/influx && \
  ln -s $GOPATH/bin/influxd /opt/influxdb/influxd && \
  ln -s $GOPATH/src/github.com/influxdb/influxdb/scripts/init.sh /opt/influxdb/init.sh

ADD config.toml /config/config.toml
ADD run.sh /run.sh
RUN chmod +x /run.sh

ENV PRE_CREATE_DB **None**
ENV SSL_SUPPORT **False**
ENV SSL_CERT **None**

# Admin server
EXPOSE 8083

# HTTP API
EXPOSE 8086

VOLUME ["/data"]

CMD ["/run.sh"]
