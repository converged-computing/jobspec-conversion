#!/bin/bash
#FLUX: --job-name=Ex5
#FLUX: -c=5
#FLUX: -t=600
#FLUX: --urgency=16

export PROCS='${SLURM_CPUS_ON_NODE}'

echo '-------------------------------'
cd ${SLURM_SUBMIT_DIR}
echo ${SLURM_SUBMIT_DIR}
echo Running on host $(hostname)
echo Time is $(date)
echo SLURM_NODES are $(echo ${SLURM_NODELIST})
echo '-------------------------------'
echo -e '\n\n'
module load MATLAB
EXEC=matlab
OPTS=' -singleCompThread -nodisplay -nosplash'
export PROCS=${SLURM_CPUS_ON_NODE}
${EXEC}${OPTS} < ex5.m
