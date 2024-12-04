#!/bin/bash
# Script para gerar um backup do diretório home do usuário.

DIRDEST="$HOME/Backup"

if [ ! -d "$DIRDEST" ]; then
    echo "Criando Diretório $DIRDEST..."
    mkdir -p "$DIRDEST"
fi

DAYS7=$(find "$DIRDEST" -ctime -7 -name "backup_home*.tgz" 2>/dev/null)

if [ "$DAYS7" ]; then
    echo "Já foi gerado um backup do diretório $HOME nos últimos 7 dias."
    read -rp "Deseja continuar? (N/s): " CONT
    CONT=${CONT,,} # Converte para minúsculas
    if [ "$CONT" = "n" ] || [ -z "$CONT" ]; then
        echo "Backup Abortado!"
        exit 1
    elif [ "$CONT" = "s" ]; then
        echo "Será criado mais um backup para a mesma semana."
    else
        echo "Opção Inválida"
        exit 2
    fi
fi       

echo "Criando Backup..." 
ARQ="backup_home_$(date +%Y%m%d%H%M).tgz" 
tar zcvpf "$DIRDEST/$ARQ" --exclude="$DIRDEST" "$HOME"/* > /dev/null 
echo 
echo "O Backup de nome \"$ARQ\" foi criado em $DIRDEST" 
echo 
echo "Backup Concluído!" 
exit 0

