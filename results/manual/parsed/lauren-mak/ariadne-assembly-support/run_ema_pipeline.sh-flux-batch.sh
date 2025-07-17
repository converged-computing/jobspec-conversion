#!/bin/bash
#FLUX: --job-name=butterscotch-buttface-7956
#FLUX: --queue=panda
#FLUX: --urgency=16

export LUIGI_CONFIG_PATH='${2}'

READ_DIR="$4"
PREFIX="$5"
WORK_DIR="${PREFIX}_ema"
SORT_PREFIX="${PREFIX}_bsort"
WHITELIST="$6"
NUM_CHUNKS="$7"
mkdir $WORK_DIR    
python3 /home/lam4003/bin/scripts/ariadne_assembly_support/cli.py interleave_fastqs ${READ_DIR}/${SORT_PREFIX} ${WORK_DIR}
cat ${WORK_DIR}/${SORT_PREFIX}.fastq | /home/lam4003/bin/ema/ema count -w ${WHITELIST} -o ${WORK_DIR}/${SORT_PREFIX}
cat ${WORK_DIR}/${SORT_PREFIX}.fastq | /home/lam4003/bin/ema/ema preproc -w  ${WHITELIST} -n ${NUM_CHUNKS} -o ${WORK_DIR}/bins  ${WORK_DIR}/${SORT_PREFIX}.ema-ncnt
spack load gcc@6.3.0
export LUIGI_CONFIG_PATH=${2}
luigid --background --logdir /athena/masonlab/scratch/users/lam4003/ariadne_data/luigi_logs
PYTHONPATH='/home/lam4003/bin/scripts/ariadne_assembly_support' luigi --module ${1}_pipeline de_Novo_Assembly --workers ${3}
