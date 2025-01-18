#!/bin/bash

set -e

# Verificar si se proporcionó un argumento
if [ $# -ne 1 ]; then
    echo "Uso: $0 <string>"
    exit 1
fi

# Obtener el string del primer argumento
input_string="$1"

# Convertir el string a hexadecimal y luego a decimal usando Python
hex_value=$(echo -n "$input_string" | xxd -p | tr -d '\n')
decimal_value=$(python3 -c "print(int('$hex_value', 16))")

echo "String original: $input_string"
echo "Valor hexadecimal: 0x$hex_value"
echo "Valor decimal (felt252): $decimal_value"

