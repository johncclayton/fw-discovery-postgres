# Because both template1 and the user postgres database have already been created,
# we need to create the hstore extension in template1 and then recreate the postgres database.
#
# Running CREATE EXTENSION in both template1 and postgres can lead to
# the extensions having different eid's.
gosu postgres psql --dbname template1 <<EOSQL
    CREATE EXTENSION hstore;
    DROP DATABASE $POSTGRES_USER;
    CREATE DATABASE $POSTGRES_USER TEMPLATE template1;
EOSQL

gosu postgres psql <<PBA8
    CREATE ROLE discovery LOGIN 
    ENCRYPTED PASSWORD 'md5b141e4a9dd3b0e9e7a2c68f55dd070db' 
    NOSUPERUSER INHERIT CREATEDB CREATEROLE NOREPLICATION;
PBA8

gosu postgres psql <<YUN4
  CREATE DATABASE discovery
  WITH OWNER = discovery
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'en_US.utf8'
       LC_CTYPE = 'en_US.utf8'
       CONNECTION LIMIT = -1;
  GRANT ALL ON DATABASE discovery TO discovery;
  GRANT CONNECT ON DATABASE discovery TO public;
YUN4

