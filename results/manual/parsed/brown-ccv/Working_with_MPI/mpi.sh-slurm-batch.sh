#!/bin/bash
#FLUX: --job-name=MyMPIJob
#FLUX: -N=2
#FLUX: -t=3600
#FLUX: --urgency=16

module load mpi/hpcx_2.7.0_intel_2020.2_slurm20
srun --mpi=pmix ./$1
