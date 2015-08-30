# docker-memcachephp

A [Docker](https://docker.com/) container for memcache.php.

## Run the container

Using the `docker` command:

    CONTAINER="memcachephp-data" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v /memcachephp \
      dockerizedrupal/data:latest

    CONTAINER="memcachephp" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 80:80 \
      -p 443:443 \
      --volumes-from memcachephp-data \
      -e SERVER_NAME="localhost" \
      -e TIMEOUT="300" \
      -e PROTOCOLS="https,http" \
      -e USERNAME="root" \
      -e PASSWORD="root" \
      -d \
      dockerizedrupal/memcachephp:latest

Using the `docker-compose` command

    TMP="$(mktemp -d)" \
      && git clone https://github.com/dockerizedrupal/docker-memcachephp.git "${TMP}" \
      && cd "${TMP}" \
      && sudo docker-compose up

## Connect directly to Memcached server by linking with another Docker container

    CONTAINER="memcachephp-data" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v /memcachephp \
      dockerizedrupal/data:latest

    CONTAINER="memcachephp" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 80:80 \
      -p 443:443 \
      --volumes-from memcachephp-data \
      --link memcached:memcached \
      -e SERVER_NAME="localhost" \
      -e TIMEOUT="300" \
      -e PROTOCOLS="https,http" \
      -e USERNAME="root" \
      -e PASSWORD="root" \
      -d \
      dockerizedrupal/memcachephp:latest

## Build the image

    TMP="$(mktemp -d)" \
      && git clone https://github.com/dockerizedrupal/docker-memcachephp.git "${TMP}" \
      && cd "${TMP}" \
      && sudo docker build -t dockerizedrupal/memcachephp:latest . \
      && cd -

## License

**MIT**
