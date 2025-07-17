#!/bin/bash
#FLUX: --job-name=loopy-rabbit-3272
#FLUX: --queue=naples,dhabi,rome
#FLUX: --urgency=16

U="$1"
SCRATCH_DIRECTORY=/scratch/${U}
mkdir -p ${SCRATCH_DIRECTORY}
cd ${SCRATCH_DIRECTORY}
DOMAIN_DIR="$2"
echo "Domain dir: ${DOMAIN_DIR}"
RESULT_DIR="$3"
DOMAIN_NAME=${DOMAIN_DIR##*/}
echo "Domain name: ${DOMAIN_NAME}"
DOMAIN="${DOMAIN_DIR}/domain.pddl"
META_DOMAIN="${DOMAIN_DIR}/meta_domain.pddl"
CACHE="${DOMAIN_DIR}/cache"
PROBLEM_NAME="p${SLURM_ARRAY_TASK_ID}"
PROBLEM="${DOMAIN_DIR}/problems/${PROBLEM_NAME}.pddl"
FD_PATH="/nfs/home/student.aau.dk/jmdh19/bin/downward/fast-downward.py"
MS_PATH="/nfs/home/student.aau.dk/jmdh19/bin/meta_solver"
FD_RUNNER="/nfs/home/student.aau.dk/jmdh19/scripts/fd_runner.sh"
MS_RUNNER="/nfs/home/student.aau.dk/jmdh19/scripts/ms_runner.sh"
sbatch --job-name=${DOMAIN_NAME}_${PROBLEM_NAME}_fd ${FD_RUNNER} ${FD_PATH} ${DOMAIN} ${PROBLEM} ${RESULT_DIR}
sbatch --job-name=${DOMAIN_NAME}_${PROBLEM_NAME}_ms ${MS_RUNNER} ${FD_PATH} ${MS_PATH} ${DOMAIN} ${PROBLEM} ${META_DOMAIN} ${CACHE} ${RESULT_DIR}
