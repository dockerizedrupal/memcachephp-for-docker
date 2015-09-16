# docker-memcachephp

A [Docker](https://docker.com/) container for memcache.php.

## Run the container

Using the `docker` command:

    CONTAINER="memcachephp-data" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v /memcachephp \
      dockerizedrupal/data:1.0.3

    CONTAINER="memcachephp" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 80:80 \
      -p 443:443 \
      --volumes-from memcachephp-data \
      -e SERVER_NAME="localhost" \
      -e TIMEZONE="Etc/UTC" \
      -e TIMEOUT="300" \
      -e PROTOCOLS="https,http" \
      -e HTTP_BASIC_AUTH_USERNAME="container" \
      -e HTTP_BASIC_AUTH_PASSWORD="" \
      -d \
      dockerizedrupal/memcachephp:1.0.6

Using the `docker-compose` command

    TMP="$(mktemp -d)" \
      && git clone https://github.com/dockerizedrupal/docker-memcachephp.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 1.0.5 \
      && sudo docker-compose up

## Connect directly to Memcached server by linking with another Docker container

    CONTAINER="memcachephp-data" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v /memcachephp \
      dockerizedrupal/data:1.0.3

    CONTAINER="memcachephp" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 80:80 \
      -p 443:443 \
      --volumes-from memcachephp-data \
      --link memcached:memcached \
      -e SERVER_NAME="localhost" \
      -e TIMEZONE="Etc/UTC" \
      -e TIMEOUT="300" \
      -e PROTOCOLS="https,http" \
      -e HTTP_BASIC_AUTH_USERNAME="container" \
      -e HTTP_BASIC_AUTH_PASSWORD="" \
      -d \
      dockerizedrupal/memcachephp:1.0.6

## Build the image

    TMP="$(mktemp -d)" \
      && git clone https://github.com/dockerizedrupal/docker-memcachephp.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 1.0.5 \
      && sudo docker build -t dockerizedrupal/memcachephp:1.0.6 . \
      && cd -

## License

**MIT**
