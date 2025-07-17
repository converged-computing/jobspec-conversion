#!/bin/bash
#FLUX: --job-name=chocolate-citrus-1563
#FLUX: -N=3
#FLUX: -n=9
#FLUX: --queue=main
#FLUX: -t=300
#FLUX: --urgency=16

module purge
module load usc
srun --mpi=pmix_v2 --ntasks $SLURM_NTASKS data/mpi_sample/mpi_hello_world
