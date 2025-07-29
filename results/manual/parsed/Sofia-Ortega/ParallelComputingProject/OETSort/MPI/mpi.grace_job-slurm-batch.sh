#!/bin/bash
#FLUX: --job-name=JobName
#FLUX: -N=16
#FLUX: -t=7200
#FLUX: --urgency=16

processes=$1
values=$2
module load intel/2020b       # load Intel software stack
module load CMake/3.12.1
CALI_CONFIG="spot(output=caliper-${values}.cali)" \
mpirun -np $processes ./oetsort $values
squeue -j $SLURM_JOBID
