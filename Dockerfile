FROM simpledrupalcloud/base:dev

MAINTAINER Simple Drupal Cloud <support@simpledrupalcloud.com>

ENV DEBIAN_FRONTEND noninteractive

ADD ./src /src

RUN apt-get update

RUN /src/build.sh
RUN /src/clean.sh

VOLUME ["/memcachephp/ssl/certs"]
VOLUME ["/memcachephp/ssl/private"]

EXPOSE 80
EXPOSE 443

CMD ["/bin/su", "-", "root", "-mc", "/src/run.sh"]
