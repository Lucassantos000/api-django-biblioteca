#!/bin/bash

# Carregar as funções do arquivo utils.sh
source /app/docker/scripts/utils.sh

# Esperar o PostgreSQL estar pronto
check_postgres

# Aplicar migracoes
aplicar_migracoes

# Verificar se o ambiente é produção e iniciar o servidor correspondente
if eh_ambiente_producao; then
    start_gunicorn  # Iniciar Gunicorn se for produção
else
    start_django_runserver  # Caso contrário, iniciar o servidor de desenvolvimento
fi

