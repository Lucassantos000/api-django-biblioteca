#!/bin/bash

# Espera o container do banco de dados Postgres ficar disponível
# Espera o container do banco de dados Postgres ficar disponível
until pg_isready -h "$DATABASE_HOST" -p "$DATABASE_PORT" -U "$DATABASE_USER"; do
    echo "Aguardando o banco de dados Postgres iniciar..."
    sleep 0.4s
done
echo "Banco de dados está pronto"

echo "Executando as migrações"
python manage.py migrate

echo "Subindo o servidor"
python manage.py runserver 0.0.0.0:8000