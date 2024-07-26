#!/bin/bash
# Filename: archivar
# Description: Crea backups de los logs

RUTA=/home/jon/logs/
DESTINO=/home/jon/backup/
declare -a FILES=(Apache Windows Hadoop Android Zookeeper)

if [ $# -gt 2 ]
then
  Fecha=$1$2$3$(date +%H%M%S)
else
  Fecha=$(date +%Y%m%d%H%M%S)
fi

for file in "${FILES[@]}"
do
  if [ ! -d "$DESTINO$file" ]
  then
     mkdir -p "$DESTINO$file"
  fi
  cd "$RUTA$file" || { echo "No se pudo cambiar al directorio $RUTA$file"; exit 1; }
  tar -zcvf "${file}${Fecha}.tar.gz" "${file}_2k.log" 2>&1
  mv "${file}${Fecha}.tar.gz" "${DESTINO}${file}" || { echo "No se pudo mover el archivo ${file}${Fecha}.tar.gz a $DESTINO$file"; exit 1; }
done

