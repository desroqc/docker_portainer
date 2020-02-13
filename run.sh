#! /bin/bash

echo "Info: Looking for SSL certificates inside volumes/certs"

if [ ! -f "$(pwd)/volumes/certs/portainer.crt" ] && [ ! -f "$(pwd)/volumes/certs/portainer.key" ]; then
  echo "Info: SSL certificates not found, creating now ..."
  set -x
  openssl genrsa -out $(pwd)/volumes/certs/portainer.key 2048
  openssl ecparam -genkey -name secp384r1 -out $(pwd)/volumes/certs/portainer.key
  openssl req -new -x509 -sha256 -key $(pwd)/volumes/certs/portainer.key -out $(pwd)/volumes/certs/portainer.crt -days 3650
  set +x
else
  echo "Info: SSL certificates OK"
fi

echo "Info: Stop and remove containers"
docker-compose down

echo "Info: Create and start containers"
docker-compose up -d
