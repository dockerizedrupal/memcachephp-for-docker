FROM viljaste/base:dev

MAINTAINER Jürgen Viljaste <j.viljaste@gmail.com>

ENV TERM xterm
ENV DEBIAN_FRONTEND noninteractive

ADD ./src /src

RUN apt-get update && /src/build.sh && /src/clean.sh

VOLUME ["/memcachephp"]

EXPOSE 80
EXPOSE 443

CMD ["/bin/su", "-", "root", "-mc", "/src/run.sh"]
