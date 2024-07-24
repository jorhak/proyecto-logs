#!/bin/bash
# Filename: archivar
# Description: Crea backups de los logs

RUTA=/home/pablo/Documentos/serviciosLog/
declare -a FILES=(Apache Windows Hadoop Android Zookeeper)

#if()
  Fecha=$(date +%Y%m%d%H%M)
#else
#fi

for file in "${FILES[@]}"
do
  cd "$RUTA$file"
  tar -zcvf $file$Fecha".tar.gz" $file"_2k.log"
done


