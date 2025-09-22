#!/bin/bash

# Função para verificar se o PostgreSQL está pronto
check_postgres() {
    until pg_isready -h $DATABASE_HOST -p $DATABASE_PORT -U postgres ; do
        echo "Aguardando o PostgreSQL iniciar..."
        sleep 2
    done
    
    # Captura o código de retorno do pg_isready
    result=$?
    
    # Verifica o código de retorno
    if [ $result -eq 0 ]; then
        echo "PostgreSQL está pronto para conexões."
    else
        echo "Erro ao tentar conectar ao PostgreSQL. Código de erro: $result"
    fi
}

# Função para iniciar o servidor Django (modo desenvolvimento)
start_django_runserver() {
    python manage.py runserver 0.0.0.0:8000
}

# Função para iniciar o Gunicorn (modo produção)
start_gunicorn() {
    gunicorn django_project.wsgi:application --bind 0.0.0.0:8000 -w $GUNICORN_WORKERS --threads $GUNICORN_THREADS -t $GUNICORN_TIMEOUT --max-requests $GUNICORN_MAX_REQUESTS
}

# Função para verificar se o ambiente é produção
eh_ambiente_producao() {
    if [ "$AMBIENTE" == "producao" ]; then
        return 0  # Retorna 0 (verdadeiro) se for produção
    else
        return 1  # Retorna 1 (falso) se não for produção
    fi
}


##### FUNÇÕES A SEREM EXECUTADAS COM O PYTHON

aplicar_migracoes() {
    python manage.py migrate
}