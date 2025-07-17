#!/bin/bash
#FLUX: --job-name=BeatnikTest
#FLUX: -N=2
#FLUX: --gpus-per-task=1
#FLUX: --queue=cup-ecs
#FLUX: -t=3600
#FLUX: --urgency=16

SPACK_INSTALL=${HOME}/spack
BEATNIK_SCRATCH=/carc/scratch/users/${USER}/beatnik-hopper
echo "Loading spack development environment"
source ${SPACK_INSTALL}/share/spack/setup-env.sh
spack load beatnik +cuda cuda_arch=80 ^cuda@11
mkdir -p ${BEATNIK_SCRATCH}/data/raw
cd ${BEATNIK_SCRATCH}
echo "Starting MPI Run with ${SLURM_NTASKS} processes"
srun -n ${SLURM_NTASKS} rocketrig -x cuda -n 8192 -F 0 -w ${SLURM_NTASKS}
echo "Finished MPI Run. Output in ${BEATNIK_SCRATCH}/data"
