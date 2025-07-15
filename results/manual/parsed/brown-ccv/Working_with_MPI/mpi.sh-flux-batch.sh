#!/bin/bash
#FLUX: --job-name=crunchy-itch-5246
#FLUX: -t=3600
#FLUX: --priority=16

module load mpi/hpcx_2.7.0_intel_2020.2_slurm20
srun --mpi=pmix ./$1
