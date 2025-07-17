#!/bin/bash
#FLUX: --job-name=tart-rabbit-7570
#FLUX: --queue=naples
#FLUX: -t=1800
#FLUX: --urgency=16

FD_PATH="$1"
DOMAIN="$2"
DOMAIN_NAME="$(dirname "$DOMAIN")"
DOMAIN_NAME=${DOMAIN_NAME##*/}
PROBLEM="$3"
PROBLEM_NAME=${PROBLEM##*/}
RESULT_DIR="$4"
RESULT_FILE="${RESULT_DIR}/${SLURM_JOBID}"
PD=$(pwd)
PROCESS_DIRECTORY=${PD}/${SLURM_JOBID}  
mkdir -p ${PROCESS_DIRECTORY}
cd ${PROCESS_DIRECTORY}
FD="${FD_PATH} --alias lama-first ${DOMAIN} ${PROBLEM}"
FD="${FD} >> /dev/null"
t1=${EPOCHREALTIME/[^0-9]/}
t1=${t1%???}
eval "${FD}"
EXIT_CODE=$?
t2=${EPOCHREALTIME/[^0-9]/}
t2=${t2%???}
FD_TIME=$(($t2 - $t1))
OUTPUT="false, ${DOMAIN_NAME}, ${PROBLEM_NAME}, ${FD_TIME}, ${FD_TIME}, false"
echo ${OUTPUT} > ${RESULT_FILE}
cd ${PD}
[ -d "${SLURM_JOBID}" ] && rm -r ${SLURM_JOBID}
exit ${EXIT_CODE}
