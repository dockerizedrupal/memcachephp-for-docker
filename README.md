# docker-memcachephp

A [Docker](https://docker.com/) container for memcache.php.

## Run the container

Using the `docker` command:

    CONTAINER="memcachephpdata" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v /memcachephp \
      viljaste/data:latest

    CONTAINER="memcachephp" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 80:80 \
      -p 443:443 \
      --volumes-from memcachephpdata \
      -e SERVER_NAME="localhost" \
      -e TIMEOUT="300" \
      -e PROTOCOLS="https" \
      -e USERNAME="root" \
      -e PASSWORD="root" \
      -d \
      viljaste/memcachephp:latest

Using the `docker-compose` command

    TMP="$(mktemp -d)" \
      && GIT_SSL_NO_VERIFY=true git clone https://git.beyondcloud.io/viljaste/docker-memcachephp.git "${TMP}" \
      && cd "${TMP}" \
      && sudo docker-compose up

## Connect directly to Memcached server by linking with another Docker container

    CONTAINER="memcachephpdata" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v /memcachephp \
      viljaste/data:latest

    CONTAINER="memcachephp" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 80:80 \
      -p 443:443 \
      --volumes-from memcachephpdata \
      --link memcached:memcached \
      -e SERVER_NAME="localhost" \
      -e TIMEOUT="300" \
      -e PROTOCOLS="https" \
      -e USERNAME="root" \
      -e PASSWORD="root" \
      -d \
      viljaste/memcachephp:latest

## Build the image

    TMP="$(mktemp -d)" \
      && git clone GIT_SSL_NO_VERIFY=true git clone https://git.beyondcloud.io/viljaste/docker-memcachephp.git "${TMP}" \
      && cd "${TMP}" \
      && sudo docker build -t viljaste/memcachephp:latest . \
      && cd -

## License

**MIT**
