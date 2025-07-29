#!/bin/bash
#SBATCH --job-name=BeatnikTest
#SBATCH --output=BeatnikTest.%j.log
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00

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
