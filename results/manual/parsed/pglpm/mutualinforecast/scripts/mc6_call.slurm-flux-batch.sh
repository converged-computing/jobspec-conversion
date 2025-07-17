#!/bin/bash
#FLUX: --job-name=prior_mc
#FLUX: --queue=CPUQ
#FLUX: -t=259200
#FLUX: --urgency=16

call="source('$1')"
WORKDIR=${SLURM_SUBMIT_DIR}
cd ${WORKDIR}
echo "we are running from this directory: $SLURM_SUBMIT_DIR"
echo "Number of nodes: $SLURM_JOB_NUM_NODES"
echo "We are using $SLURM_CPUS_ON_NODE cores"
echo "Total of $SLURM_NTASKS cores"
echo ""
module purge
module load GCC/8.3.0 OpenMPI/3.1.4  R/3.6.2 netCDF/4.7.1
Rscript -e $call ${SLURM_ARRAY_TASK_ID}
