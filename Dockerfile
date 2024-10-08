FROM postgres:15.8-alpine3.19

MAINTAINER KhulnaSoft Ltd
LABEL khulnasoft.role=system

ENV KENGINE_POSTGRES_USER_DB_HOST=kengine-postgres \
    KENGINE_POSTGRES_USER_DB_PORT=5432 \
    KENGINE_POSTGRES_USER_DB_USER=khulnasoft \
    KENGINE_POSTGRES_USER_DB_PASSWORD=khulnasoft \
    KENGINE_POSTGRES_USER_DB_NAME=users \
    KENGINE_POSTGRES_USER_DB_SSLMODE=disable \
    DF_PROG_NAME="postgres1" \
    PGDATA="/data/postgres1/data"
#ENV PGDATA /var/lib/postgresql/data
#ENV POSTGRES_INITDB_XLOGDIR /var/log/postgresql/logs

COPY create-pg-dirs.sh /usr/local/bin/
COPY pg-export.sh /usr/local/bin/
COPY pg-import.sh /usr/local/bin/
COPY create-pg-db.sh /docker-entrypoint-initdb.d/
RUN cp /usr/local/bin/docker-entrypoint.sh /usr/local/bin/new-docker-entrypoint.sh
COPY postgres-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod 755 /usr/local/bin/*.sh
#The script create-pd-dirs.sh will copy postgresql.conf file into PGDATA
#COPY postgresql.conf /usr/local/
