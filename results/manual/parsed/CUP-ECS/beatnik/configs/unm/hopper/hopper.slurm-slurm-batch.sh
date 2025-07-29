#!/bin/bash
#SBATCH --job-name=BeatnikTest
#SBATCH --output=BeatnikTest.%j.log
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --partition=cup-ecs

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
