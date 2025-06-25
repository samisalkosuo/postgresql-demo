FROM docker.io/postgres:17.5-alpine3.21


ENV POSTGRES_PASSWORD=passw0rd
ENV POSTGRES_USER=postgres
ENV POSTGRES_DB=postgres
ENV PGDATA=/data/pgdata 
#use: -v /custom/mount:/data

#custom database, user and password
ENV DB_NAME=mydb
ENV DB_USER_NAME=user1
ENV DB_USER_PASSWORD=passw0rd

#add certificates
RUN mkdir -p /certs
COPY certs/ /certs/
RUN chmod 0600 -R /certs/* && chown postgres:postgres -R /certs

#config
COPY postgresql.conf /tmp/
COPY pg_hba.conf /tmp/

#init scripts
COPY scripts/* /docker-entrypoint-initdb.d/

EXPOSE 5432

CMD ["postgres", "-c", "config_file=/tmp/postgresql.conf","-c","hba_file=/tmp/pg_hba.conf"]
