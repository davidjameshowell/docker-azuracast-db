FROM mariadb:10.2

# Sensible default environment values for AzuraCast instances
ENV MYSQL_HOST="mariadb" \
    MYSQL_PORT=3306 \
    MYSQL_USER="azuracast" \
    MYSQL_PASSWORD="azur4c457" \
    MYSQL_DATABASE="azuracast" \
    MYSQL_RANDOM_ROOT_PASSWORD="yes"

# Placeholder Docker file to ensure the AzuraCast docker-compose file always refers to the newest supported image.