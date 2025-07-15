#!/bin/bash
#FLUX: --job-name=conspicuous-platanos-1363
#FLUX: --exclusive
#FLUX: --queue=dev
#FLUX: -t=86400
#FLUX: --priority=16

srun -v -v -N 4 -n 4 spack install \
  -v -y \
  --deprecated \
  --show-log-on-error \
  --no-check-signature \
  --no-checksum \
  gromacs@2022 \
  gromacs@2022 +cuda +mpi \
  gromacs@2022 +cuda ~mpi
