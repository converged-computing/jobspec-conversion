#!/bin/bash
#FLUX: --job-name=crunchy-fork-5902
#FLUX: --urgency=16

source ~/.bash_profile
init_conda
cd /mnt/ceph/users/apricewhelan/projects/apogee-dr17-distances
date
mpirun python3 -m mpi4py.run -rc thread_level='funneled' \
$CONDA_PREFIX/bin/joaquin train -c config.yml -v --mpi
date
