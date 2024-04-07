FROM mysql:8.0
ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=sakila
COPY 1sakila-schema.sql /docker-entrypoint-initdb.d/
COPY 2sakila-data.sql /docker-entrypoint-initdb.d/