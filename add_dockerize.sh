ARCH=$(uname -r)
SUB="aarch64"

DOCKERIZE_ARCH="amd64"
DOCKERIZE_VERSION="v0.6.1"

if grep -q "$SUB" <<< "$ARCH"; then
  echo "ARM detected, set arch version"
  DOCKERIZE_ARCH="armhf"
fi

wget https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-linux-${DOCKERIZE_ARCH}-${DOCKERIZE_VERSION}.tar.gz
tar -C /usr/local/bin -xzvf dockerize-linux-${DOCKERIZE_ARCH}-${DOCKERIZE_VERSION}.tar.gz
rm dockerize-linux-${DOCKERIZE_ARCH}-${DOCKERIZE_VERSION}.tar.gz
