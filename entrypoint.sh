#!/bin/sh

echo "Waiting for postgres..."

while ! nc -z db 5432; do
  echo "db:5432 - no response"
  echo "Waiting for postgres to be ready..."
  sleep 2
done

echo "PostgreSQL is ready!"
echo "Current directory: $(pwd)"
echo "Directory contents:"
ls -la

exec ./app