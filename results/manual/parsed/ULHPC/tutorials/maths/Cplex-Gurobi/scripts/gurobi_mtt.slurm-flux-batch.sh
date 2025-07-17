#!/bin/bash
#FLUX: --job-name=Multi-threaded_gurobi
#FLUX: -c=28
#FLUX: --queue=batch
#FLUX: -t=3600
#FLUX: --urgency=16

export SRUN_CPUS_PER_TASK='${SLURM_CPUS_PER_TASK}'

export SRUN_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK}
module load math/Gurobi/8.1.1-intel-2018a-Python-3.6.4
MPS_FILE=$1
RES_FILE=$2
gurobi_cl Threads=${SLURM_CPUS_PER_TASK} ResultFile="${RES_FILE}.sol" ${MPS_FILE}
