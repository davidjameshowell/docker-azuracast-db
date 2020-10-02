# docker-azuracast-db
The MariaDB docker container for AzuraCast.

### Making a new DB Dump

- Run system backup; extract `db.sql` from backup file.

- Remove all INSERT sections except `app_migrations` table.

- Remove all AUTO_INCREMENT settings.

- Prepend to the top:
```
CREATE DATABASE /*!32312 IF NOT EXISTS*/ `azuracast`;
USE `azuracast`;

ALTER DATABASE `azuracast` CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci;
``