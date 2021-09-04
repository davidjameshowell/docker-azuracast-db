FROM mariadb:10.5-focal

# Fix locales and update packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends language-pack-en \
    && locale-gen en_US \
    && update-locale LANG=en_US.UTF-8 LC_CTYPE=en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

ENV LANGUAGE="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8" \
    LANG="en_US.UTF-8"

# Add Dockerize
ENV DOCKERIZE_VERSION v0.6.1

COPY add_dockerize.sh /tmp/add_dockerize.sh

RUN apt-get update \
    && apt-get install -y --no-install-recommends wget ca-certificates openssl \
    && bash /tmp/add_dockerize.sh \
    && apt-get purge -y --auto-remove wget ca-certificates openssl \
    && rm -rf /var/lib/apt/lists/*

# Sensible default environment values for AzuraCast instances
ENV MYSQL_HOST="mariadb" \
    MYSQL_PORT=3306 \
    MYSQL_USER="azuracast" \
    MYSQL_PASSWORD="azur4c457" \
    MYSQL_DATABASE="azuracast" \
    MYSQL_SLOW_QUERY_LOG=0

COPY ./db.cnf.tmpl /tmp/db.cnf.tmpl
COPY ./db.sql /docker-entrypoint-initdb.d/00-azuracast.sql

COPY scripts/ /usr/local/bin
RUN chmod -R a+x /usr/local/bin

# Note: Docker erases BOTH entrypoint and cmd if you set one or the other in an inherited Dockerfile.
ENTRYPOINT ["dockerize", "-template", "/tmp/db.cnf.tmpl:/etc/mysql/conf.d/db.cnf", "/usr/local/bin/docker-entrypoint.sh"]
CMD ["mysqld"]
