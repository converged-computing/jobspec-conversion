#!/bin/bash
#SBATCH --nodes=4
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=dev
#SBATCH: --exclusive
#SBATCH --constraint=m5a4xlarge

srun -v -v -N 4 -n 4 spack install \
  -v -y \
  --deprecated \
  --no-check-signature \
  --no-checksum \
  --use-cache \
  relion@3.1.3 \
  relion@4.0-beta
spack install \
  --no-check-signature \
  --no-checksum \
  --use-cache \
  relion@3.1.3 ~mklfft ~cuda \
  relion@4.0-beta ~mklfft ~cuda \
  relion@3.1.3 ~mklfft +cuda \
  relion@4.0-beta ~mklfft +cuda
