#!/bin/bash
#FLUX: --job-name=apogee-setup
#FLUX: -N=2
#FLUX: --queue=cca
#FLUX: -t=14400
#FLUX: --urgency=16

cd /mnt/ceph/users/apricewhelan/projects/apogee-dr17-binaries/vac-pipeline
source hq-config/init.sh
echo $HQ_RUN_PATH
date
mpirun python3 -m mpi4py.run -rc thread_level='funneled' \
$CONDA_PREFIX/bin/hq make_prior_cache -v --mpi
hq make_tasks -v
date
