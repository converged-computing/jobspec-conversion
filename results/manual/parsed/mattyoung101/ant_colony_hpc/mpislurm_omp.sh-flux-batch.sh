#!/bin/bash
#FLUX: --job-name=ant_colony
#FLUX: -c=20
#FLUX: -t=28800
#FLUX: --priority=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

module load gnu
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
date
mpiexec ./cmake-build-release-getafix/ant_colony antconfig_megamap_mpi.ini
