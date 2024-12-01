#!/bin/sh

set -e

host="$POSTGRE_HOST"
port="$POSTGRE_PORT"

until nc -z "$host" "$port"; do
  echo "Waiting for PostgreSQL at $host:$port..."
  sleep 1
done

exec "$@"
