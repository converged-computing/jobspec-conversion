#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=dev
#SBATCH: --exclusive
#SBATCH --constraint=m5a4xlarge

spack install \
  --no-check-signature \
  --no-checksum \
  --use-cache \
  py-tensorflow +cuda \
  py-torch +cuda \
  py-scikit-learn \
  py-scikit-image \
  py-scipy \
  py-scikit-optimize \
  py-scientificpython \
  py-ipykernel
