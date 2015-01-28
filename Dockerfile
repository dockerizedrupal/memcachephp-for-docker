FROM simpledrupalcloud/base:dev

MAINTAINER Simple Drupal Cloud <support@simpledrupalcloud.com>

ENV TERM xterm
ENV DEBIAN_FRONTEND noninteractive

ADD ./src /src

RUN apt-get update

RUN /src/build.sh
RUN /src/clean.sh

VOLUME ["/memcachephp"]

EXPOSE 80
EXPOSE 443

CMD ["/bin/su", "-", "root", "-mc", "/src/run.sh"]
