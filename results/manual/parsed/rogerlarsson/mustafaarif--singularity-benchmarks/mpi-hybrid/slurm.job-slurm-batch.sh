#!/bin/bash
#FLUX: --job-name=mpi_test
#FLUX: -N=2
#FLUX: --queue=main
#FLUX: -t=300
#FLUX: --urgency=16

srun --ntasks=1 singularity exec ./mpi-bw-hybrid.sif bash -c 'ldd /mpiapp/mpi_bandwidth'
srun --mpi=pmi2 -n 256 singularity exec ./mpi-bw-hybrid.sif bash -c '/mpiapp/mpi_bandwidth'
