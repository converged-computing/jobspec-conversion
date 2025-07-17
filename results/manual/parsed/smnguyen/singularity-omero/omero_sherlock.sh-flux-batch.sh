#!/bin/bash
#FLUX: --job-name=crunchy-car-3632
#FLUX: -c=3
#FLUX: --queue=mcovert
#FLUX: -t=84600
#FLUX: --urgency=16

function get_port {
  local DESIRED_PORT=$1
  while [ $(netstat -lnt | grep ":$DESIRED_PORT " | wc -l) -ne 0 ]; do
    (( DESIRED_PORT++ ))
  done
  echo $DESIRED_PORT
}
PGPASSWORD=covert_omero
cd /share/PI/mcovert/omero
module load singularity/2.2
set -x
PG_PORT=$(get_port 25432)
REGISTRY_PORT=$(get_port 24061)
TCP_PORT=$(get_port 24063)
SSL_PORT=$(get_port 24064)
WEB_PORT=$(get_port 24080)
HTTP_PORT=$(get_port 28080)
exec singularity run -w -B "./data:/omero/data" -B "./var:/omero/var" -B "./postgres:/omero/postgres" -B "./run:/omero/run" -B "./user_scripts:/omero/user_scripts" omero.img --pg-port $PG_PORT --pg-password $PGPASSWORD --server-registry-port $REGISTRY_PORT --server-tcp-port $TCP_PORT --server-ssl-port $SSL_PORT --web $WEB_PORT --http $HTTP_PORT
