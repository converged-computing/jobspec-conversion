#!/bin/bash
#FLUX: --job-name=blank-salad-0722
#FLUX: --priority=16

cd /mnt/ceph/users/apricewhelan/projects/apogee-dr17-binaries/simulated-test
source hq-config/init.sh
echo $HQ_RUN_PATH
date
mpirun python3 -m mpi4py.run -rc thread_level='funneled' \
$CONDA_PREFIX/bin/hq run_thejoker -v --mpi
date
