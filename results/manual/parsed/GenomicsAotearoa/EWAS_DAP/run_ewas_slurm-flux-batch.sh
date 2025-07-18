#!/bin/bash
#FLUX: --job-name=ewas
#FLUX: -t=3600
#FLUX: --urgency=16

export EWAS_PORT='10083  # port must not in use by other users, make sure it is the same port your forwarded to the cluster'
export EWAS_IMG='${PWD}/ewas.img  # path to the EWAS singularity image you uploaded'
export EWAS_ROOT='${PWD}/ewas_data  # EWAS data directory paths'
export EWAS_OUT='${EWAS_ROOT}/out'
export EWAS_UPLOADS='${EWAS_ROOT}/uploads'
export EWAS_RESULTS='${EWAS_UPLOADS}/results'
export EWAS_TEMP='${PWD}/temp'

if [ -f .env ]
then
  export $(cat .env | xargs)
fi
if [ -f ~/ewas_config ]
then
  export $(cat ~/ewas_config | xargs)
fi
export EWAS_PORT=10083  # port must not in use by other users, make sure it is the same port your forwarded to the cluster
export EWAS_IMG=${PWD}/ewas.img  # path to the EWAS singularity image you uploaded
export EWAS_ROOT=${PWD}/ewas_data  # EWAS data directory paths
export EWAS_OUT=${EWAS_ROOT}/out
export EWAS_UPLOADS=${EWAS_ROOT}/uploads
export EWAS_RESULTS=${EWAS_UPLOADS}/results
export EWAS_TEMP=${PWD}/temp
module load Singularity
echo "EWAS will be started on $(hostname) and port forwarding established from $SLURM_SUBMIT_HOST on port ${EWAS_PORT}"
ssh -N -R ${EWAS_PORT}:localhost:${EWAS_PORT} $SLURM_SUBMIT_HOST &
mkdir -p $EWAS_TEMP
mkdir -p $EWAS_OUT
mkdir -p $EWAS_UPLOADS
mkdir -p $EWAS_RESULTS
cat << EOF > myports.conf
Listen $EWAS_PORT
<IfModule ssl_module>
        Listen 443
</IfModule>
<IfModule mod_gnutls.c>
        Listen 443
</IfModule>
Alias "/files" "/mnt/data/uploads/results"
<Directory "/mnt/data/uploads/results">
    Require all granted
</Directory>
EOF
singularity run --writable-tmpfs --no-home -B ${EWAS_TEMP}:/var/run/apache2/,${PWD}/ewas_data/uploads:/mnt/data/uploads,${PWD}/myports.conf:/etc/apache2/ports.conf ${EWAS_IMG} /var/www/html/main.sh -o  ${EWAS_OUT} \
 -u ${EWAS_UPLOADS} -r ${EWAS_RESULTS} -t ${EWAS_ROOT} -f ${EWAS_EMAIL_FROM}  -h ${EWAS_EMAIL_HOST}  -p ${EWAS_EMAIL_PORT} -s ${EWAS_EMAIL_USER} -w ${EWAS_EMAIL_PASSWORD}  $@
