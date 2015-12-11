FROM postgres:latest
MAINTAINER John Clayton
ADD create_extension.sh docker-entrypoint-initdb.d/create_extension.sh
