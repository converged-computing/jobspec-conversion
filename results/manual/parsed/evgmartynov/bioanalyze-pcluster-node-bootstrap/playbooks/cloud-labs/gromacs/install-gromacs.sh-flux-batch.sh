#!/bin/bash
#FLUX: --job-name=faux-omelette-2736
#FLUX: -N=4
#FLUX: -n=4
#FLUX: --exclusive
#FLUX: --queue=dev
#FLUX: -t=86400
#FLUX: --urgency=16

srun -v -v -N 4 -n 4 spack install \
  -v -y \
  --deprecated \
  --show-log-on-error \
  --no-check-signature \
  --no-checksum \
  gromacs@2022 \
  gromacs@2022 +cuda +mpi \
  gromacs@2022 +cuda ~mpi
