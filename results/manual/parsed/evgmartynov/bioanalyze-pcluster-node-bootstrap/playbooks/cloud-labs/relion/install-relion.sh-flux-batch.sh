#!/bin/bash
#FLUX: --job-name=adorable-sundae-8724
#FLUX: --exclusive
#FLUX: --queue=dev
#FLUX: -t=86400
#FLUX: --priority=16

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
