# SPTI Scripts

## Script 1
1. Dando permisos de ejecución al script básico
````bash
chmod +x /home/count_txt_lines.sh
````

2. Ejecutando el script básico del punto 1
````bash
cd /home && ./count_txt_lines.sh
````

## Script 2

1. Crear archivos de prueba
````bash
mkdir -p /home/test_files && cd /home/test_files && \
echo -e "Línea 1\nLínea 2\nLínea 3" > archivo1.txt && \
echo -e "Una sola línea" > archivo2.txt && \
echo -e "L1\nL2\nL3\nL4\nL5\nL6\nL7\nL8\nL9\nL10" > archivo3.txt && \
echo -e "Alpha\nBeta" > subdir/archivo4.txt && \
ls -la
````

1.1. Archivos de prueba con subidrectorio

````bash
mkdir -p /home/claude/test_files/subdir && cd /home/claude/test_files && \
echo -e "Línea 1\nLínea 2\nLínea 3" > archivo1.txt && \
echo -e "Una sola línea" > archivo2.txt && \
echo -e "L1\nL2\nL3\nL4\nL5\nL6\nL7\nL8\nL9\nL10" > archivo3.txt && \
echo -e "Alpha\nBeta" > subdir/archivo4.txt && \
ls -laR
````

2. Ejecutando el script mejorado sobre los archivos de prueba
````bash
cd /home && ./count_txt_lines_advanced.sh /home/test_files
````

3. Mostrando el contenido del archivo de reporte generado
````bash
cat txt_lines_report.txt
````

4. Mostrando el archivo de reporte con ruta completa
````bash
cat /home/txt_lines_report.txt
````

## Otras ejemplos de ejecución
Uso del script mejorado:
````bash
bash./count_txt_lines_advanced.sh                    # Busca en $HOME
./count_txt_lines_advanced.sh /etc               # Busca en /etc
./count_txt_lines_advanced.sh /var/log mi_reporte.txt  # Personalizado
````
