#!/bin/bash
#FLUX: --job-name=parallelSlurm
#FLUX: -N=2
#FLUX: -t=1800
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
module load gnu/9.1.0
module load openmpi/1.10.7
module load mkl/2019.0.5
module load R/4.0.2
mpirun -np 1 R --slave < Rmpi.R
hostname
