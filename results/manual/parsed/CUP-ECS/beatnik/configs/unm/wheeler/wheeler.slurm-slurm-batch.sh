#!/bin/bash
#FLUX: --job-name=BeatnikTest
#FLUX: -N=2
#FLUX: -t=3600
#FLUX: --urgency=16

SPACK_INSTALL=${HOME}/spack
BEATNIK_SCRATCH=/carc/scratch/users/${USER}/beatnik-wheeler
echo "Loading spack and beatnik"
source ${SPACK_INSTALL}/share/spack/setup-env.sh
spack load beatnik
mkdir -p ${BEATNIK_SCRATCH}/data/raw
cd ${BEATNIK_SCRATCH}
echo "Starting MPI Run with ${SLURM_NTASKS} processes"
srun -n ${SLURM_NTASKS} rocketrig -n 512 -F 0 -w ${SLURM_NTASKS}
echo "Finished MPI Run. Output in ${BEATNIK_SCRATCH}/data"
