#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    
-- Create user and database
CREATE USER $DB_USER_NAME;
ALTER USER $DB_USER_NAME WITH PASSWORD '$DB_USER_PASSWORD';
CREATE DATABASE $DB_NAME;
GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USER_NAME;
\c $DB_NAME;

GRANT ALL PRIVILEGES ON SCHEMA public TO $DB_USER_NAME;

-- Grants USAGE (which includes SELECT) on all schemas.
-- Grants SELECT on all tables, views, and sequences.  
GRANT pg_read_all_data TO $DB_USER_NAME;

-- Grants USAGE on all schemas.
-- Grants INSERT, UPDATE, DELETE on all tables, views, and sequences.
GRANT pg_write_all_data TO $DB_USER_NAME;

EOSQL
