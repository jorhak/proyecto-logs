#!/bin/bash
# Filename: archivar
# Description: Crea backups de los logs

RUTA=/home/pablo/Documentos/Logs/
DESTINO=/home/pablo/Documentos/serviciosLog/
declare -a FILES=(Apache Windows Hadoop Android Zookeeper)

if [ $# -gt 2 ]
then
  Fecha=$1$2$3$(date +%H%M%S)
else
  Fecha=$(date +%Y%m%d%H%M%S)
fi

for file in "${FILES[@]}"
do
  cd "$RUTA$file"
  tar -zcvf $file$Fecha".tar.gz" $file"_2k.log"
  mv $file$Fecha".tar.gz" $DESTINO$file
done

