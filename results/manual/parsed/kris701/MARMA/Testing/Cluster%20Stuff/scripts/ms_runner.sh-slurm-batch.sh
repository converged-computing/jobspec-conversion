#!/bin/bash
#SBATCH --output=/nfs/home/student.aau.dk/jmdh19/slurm-output/ms_runner-%A.out
#SBATCH --error=/nfs/home/student.aau.dk/jmdh19/slurm-output/ms_runner-%A.err
#SBATCH --mail-user=jmdh19@student.aau.dk
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=00:30:00
#SBATCH --partition=naples

FAST_DOWNWARD="$1"
META_SOLVER="$2"
DOMAIN="$3"
DOMAIN_NAME="$(dirname "$DOMAIN")"
DOMAIN_NAME=${DOMAIN_NAME##*/}
PROBLEM="$4"
PROBLEM_NAME=${PROBLEM##*/}
META_DOMAIN="$5"
CACHE="$6"
RESULT_DIR="$7"
RESULT_FILE="${RESULT_DIR}/${SLURM_JOBID}"
PD=$(pwd)
PROCESS_DIRECTORY=${PD}/${SLURM_JOBID}
mkdir -p ${PROCESS_DIRECTORY}
cd ${PROCESS_DIRECTORY}
MS="${META_SOLVER} -d ${DOMAIN} -m ${META_DOMAIN} -p ${PROBLEM} -f ${FAST_DOWNWARD} -c ${CACHE}"
MS="${MS} >> /dev/null"
t1=${EPOCHREALTIME/[^0-9]/}
t1=${t1%???}
eval "${MS}"
EXIT_CODE=$?
t2=${EPOCHREALTIME/[^0-9]/}
t2=${t2%???}
MS_TIME=$(($t2 - $t1))
OUTPUT="true, ${DOMAIN_NAME}, ${PROBLEM_NAME}, ${MS_TIME}, ${MS_TIME}, false"
echo ${OUTPUT} > ${RESULT_FILE}
cd ${PD}
[ -d "${SLURM_JOBID}" ] && rm -r ${SLURM_JOBID}
exit ${EXIT_CODE}
