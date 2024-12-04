#!/bin/bash
#Objetivo do script simples para somar dois valores.
#
read -p "Informe o Valor 1: " VALOR1
read -p "Informe o Valor 2: " VALOR2

echo
echo "A soma de $VALOR1 + $VALOR2 é $(expr $VALOR1 + $VALOR2)"
