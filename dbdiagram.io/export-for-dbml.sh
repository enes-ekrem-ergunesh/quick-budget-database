#!/bin/bash
set -a && source ../../.env && set +a

# Create a dump to import on dbdiagram.io
PGPASSWORD="$POSTGRES_PASSWORD" pg_dump -h 127.0.0.1 -p $POSTGRES_HOST_PORT -d $POSTGRES_DB -U $POSTGRES_USER -s -F p -E UTF-8 -f ./dump.sql