#!/bin/bash
#FLUX: --job-name=chunky-egg-4346
#FLUX: -c=28
#FLUX: -t=3600
#FLUX: --priority=16

module load math/Gurobi/8.1.1-intel-2018a-Python-3.6.4
MPS_FILE=$1
RES_FILE=$2
gurobi_cl Threads=${SLURM_CPUS_PER_TASK} ResultFile="${RES_FILE}.sol" ${MPS_FILE}
