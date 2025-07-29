#!/bin/bash
#SBATCH --nodes=4
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --exclusive
#SBATCH --constraint=m5a4xlarge

srun -v -v -N 4 -n 4 spack install \
  -v -y \
  --deprecated \
  --show-log-on-error \
  --no-check-signature \
  --no-checksum \
  gromacs@2022 \
  gromacs@2022 +cuda +mpi \
  gromacs@2022 +cuda ~mpi
