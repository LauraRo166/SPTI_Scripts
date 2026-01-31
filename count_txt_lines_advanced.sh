#!/bin/bash

# Script mejorado para encontrar archivos .txt
# Acepta directorio base como argumento
# Guarda los resultados en un archivo

# Función para mostrar uso
show_usage() {
    echo "Uso: $0 [DIRECTORIO] [ARCHIVO_SALIDA]"
    echo ""
    echo "Busca archivos .txt en DIRECTORIO y cuenta sus líneas"
    echo ""
    echo "Argumentos:"
    echo "  DIRECTORIO      Directorio base para buscar (default: \$HOME)"
    echo "  ARCHIVO_SALIDA  Archivo donde guardar resultados (default: txt_lines_report.txt)"
    echo ""
    echo "Ejemplos:"
    echo "  $0                          # Busca en \$HOME, guarda en txt_lines_report.txt"
    echo "  $0 /etc                     # Busca en /etc, guarda en txt_lines_report.txt"
    echo "  $0 /var/log results.txt     # Busca en /var/log, guarda en results.txt"
}

# Parsear argumentos
BASE_DIR="${1:-$HOME}"
OUTPUT_FILE="${2:-txt_lines_report.txt}"

# Validar que el directorio existe
if [ ! -d "$BASE_DIR" ]; then
    echo "Error: El directorio '$BASE_DIR' no existe"
    echo ""
    show_usage
    exit 1
fi

# Información inicial
echo "=============================================="
echo "Búsqueda de archivos .txt"
echo "=============================================="
echo "Directorio base: $BASE_DIR"
echo "Archivo de salida: $OUTPUT_FILE"
echo "Fecha: $(date '+%Y-%m-%d %H:%M:%S')"
echo "=============================================="
echo ""

# Iniciar archivo de salida
{
    echo "=============================================="
    echo "Reporte de archivos .txt por número de líneas"
    echo "=============================================="
    echo "Directorio base: $BASE_DIR"
    echo "Fecha: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "=============================================="
    echo ""
} > "$OUTPUT_FILE"

# Array temporal para almacenar resultados
declare -a results
count=0

echo "Buscando archivos .txt..."

# Buscar todos los archivos .txt en el directorio especificado
while IFS= read -r -d '' file; do
    # Contar líneas del archivo
    lines=$(wc -l < "$file" 2>/dev/null)
    
    # Almacenar resultado en formato "líneas|archivo"
    results+=("$lines|$file")
    ((count++))
done < <(find "$BASE_DIR" -type f -name "*.txt" -print0 2>/dev/null)

echo "Encontrados $count archivos .txt"
echo ""

# Si no se encontraron archivos
if [ $count -eq 0 ]; then
    echo "No se encontraron archivos .txt en $BASE_DIR"
    echo ""
    echo "No se encontraron archivos .txt en $BASE_DIR" >> "$OUTPUT_FILE"
    exit 0
fi

# Ordenar y mostrar resultados
echo "Resultados (ordenados por número de líneas):"
echo "--------------------------------------------"

# Calcular total de líneas
total_lines=0

# Ordenar por número de líneas (descendente) y procesar
printf '%s\n' "${results[@]}" | sort -t'|' -k1 -nr | while IFS='|' read -r lines file; do
    # Mostrar en pantalla
    printf "%8d líneas: %s\n" "$lines" "$file"
    
    # Guardar en archivo
    printf "%8d líneas: %s\n" "$lines" "$file" >> "$OUTPUT_FILE"
done

# Resumen final
echo ""
echo "=============================================="
echo "Resumen:"
echo "  Total de archivos .txt: $count"
echo "  Resultados guardados en: $OUTPUT_FILE"
echo "=============================================="

# Agregar resumen al archivo
{
    echo ""
    echo "=============================================="
    echo "Resumen:"
    echo "  Total de archivos .txt encontrados: $count"
    echo "=============================================="
} >> "$OUTPUT_FILE"

echo ""
echo "✓ Proceso completado exitosamente"
