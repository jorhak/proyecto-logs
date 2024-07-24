#!/bin/bash
# Filename: archivar
# Description: Crea backups de los logs

if [ $# -gt 1 ]
then
  Mes=$2
  Anio=$1
else
  Mes=$(date +%m)
  Anio=$(date +%Y)
fi

mkdir -p "./$Anio/$Mes"
mv ./serviciosLog/* "./$Anio/$Mes"

#echo "$Mes  $Anio"
scp -r "./$Anio" pablo@192.168.0.22:/home/pablo/Descargas
cd ./serviciosLog
mkdir Apache Android Windows Hadoop Zookeeper
