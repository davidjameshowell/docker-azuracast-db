ARCH=$(uname -a)
SUB="aarch64"

DOCKERIZE_ARCH="amd64"
DOCKERIZE_VERSION="v0.6.1"

if grep -q "$SUB" <<< "$ARCH"; then
  echo "ARM detected, set arch version"
  DOCKERIZE_ARCH="armhf"
fi

apt-get update \
&& apt-get install -y --no-install-recommends wget ca-certificates openssl \
&& apt-get purge -y --auto-remove wget ca-certificates openssl \
&& rm -rf /var/lib/apt/lists/*

wget https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-linux-${DOCKERIZE_ARCH}-${DOCKERIZE_VERSION}.tar.gz
tar -C /usr/local/bin -xzvf dockerize-linux-${DOCKERIZE_ARCH}-${DOCKERIZE_VERSION}.tar.gz
rm dockerize-linux-${DOCKERIZE_ARCH}-${DOCKERIZE_VERSION}.tar.gz
