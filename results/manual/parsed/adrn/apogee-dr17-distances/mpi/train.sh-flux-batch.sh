#!/bin/bash
#FLUX: --job-name=joaquin-train
#FLUX: -N=4
#FLUX: --queue=cca
#FLUX: -t=43200
#FLUX: --urgency=16

source ~/.bash_profile
init_conda
cd /mnt/ceph/users/apricewhelan/projects/apogee-dr17-distances
date
mpirun python3 -m mpi4py.run -rc thread_level='funneled' \
$CONDA_PREFIX/bin/joaquin train -c config.yml -v --mpi
date
