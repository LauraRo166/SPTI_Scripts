#!/bin/bash

# Script para encontrar archivos .txt en el directorio home
# Cuenta las líneas de cada archivo y las ordena por número de líneas

echo "Buscando archivos .txt en el directorio home..."
echo "=============================================="

# Array temporal para almacenar resultados
declare -a results

# Buscar todos los archivos .txt en el directorio home
while IFS= read -r -d '' file; do
    # Contar líneas del archivo
    lines=$(wc -l < "$file" 2>/dev/null)
    
    # Almacenar resultado en formato "líneas|archivo"
    results+=("$lines|$file")
done < <(find "$HOME" -type f -name "*.txt" -print0 2>/dev/null)

# Ordenar resultados por número de líneas (descendente) y mostrar
printf '%s\n' "${results[@]}" | sort -t'|' -k1 -nr | while IFS='|' read -r lines file; do
    printf "%6d líneas: %s\n" "$lines" "$file"
done

echo "=============================================="
echo "Búsqueda completada"
