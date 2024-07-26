#!/bin/bash
# Filename: rotacion
# Description: Mueve los ficheros .tar.gz al servidor
# remoto


BACKUP=/home/jon/backup/
declare -a SERVICES=(Apache Windows Hadoop Android Zookeeper)
if [ $# -gt 1 ]
then
  MONTH=$2
  YEAR=$1
else
  MONTH=$(date +%m)
  YEAR=$(date +%Y)
fi
for SERVICE in "${SERVICES[@]}"
do
   if [ -d "$BACKUP$SERVICE" ]
   then
      ssh jon@remoto "mkdir -p ${BACKUP}${SERVICE}/${YEAR}/${MONTH}"
      FILES_TO_COPY="${BACKUP}${SERVICE}/${SERVICE}${YEAR}${MONTH}*.tar.gz"
      for file in $FILES_TO_COPY
      do
        if [ -e "$file" ]; then
          scp "$file" jon@remoto:"${BACKUP}${SERVICE}/${YEAR}/${MONTH}"
        else
          echo "No hay archivos para copiar para el servicio $SERVICE en ${YEAR}-${MONTH}"
        fi
      done
      DATE_OLD=$(date -d "${YEAR}-${MONTH}-01 -3 month" +%Y%m)
      YEAR_OLD=${DATE_OLD:0:4}
      MONTH_OLD=${DATE_OLD:4:2}
    
      FILES_TO_DELETE="${BACKUP}${SERVICE}/${SERVICE}${YEAR_OLD}${MONTH_OLD}*.tar.gz"
      if ls $FILES_TO_DELETE 1> /dev/null 2>&1 
      then
         rm $FILES_TO_DELETE
      else
         echo "No hay archivos para eliminar para el servicio $SERVICE en ${YEAR_OLD}-${MONTH_OLD}"
      fi   
   else
      echo "El directorio <<${BACKUP}${SERVICE}>> no existe"   
   fi
done
