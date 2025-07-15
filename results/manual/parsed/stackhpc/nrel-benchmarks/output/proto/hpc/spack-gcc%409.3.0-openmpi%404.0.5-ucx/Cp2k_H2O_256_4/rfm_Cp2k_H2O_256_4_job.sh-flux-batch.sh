#!/bin/bash
#FLUX: --job-name=rfm_Cp2k_H2O_256_4_job
#FLUX: -n=64
#FLUX: --exclusive
#FLUX: --queue=hpc
#FLUX: --urgency=16

export SLURM_MPI_TYPE='pmix_v3'

export SLURM_MPI_TYPE=pmix_v3
spack load cp2k
time \
srun cp2k.popt H2O-256.inp
