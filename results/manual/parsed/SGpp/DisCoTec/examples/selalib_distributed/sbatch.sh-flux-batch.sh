#!/bin/bash
#FLUX: --job-name=fuzzy-chip-6183
#FLUX: -n=9
#FLUX: -t=259200
#FLUX: --priority=16

export OMP_NUM_THREADS='1;export OMP_PLACES=cores;export OMP_PROC_BIND=close'

NGROUP=$(grep ngroup ctparam | awk -F"=" '{print $2}')
NPROCS=$(grep nprocs ctparam | awk -F"=" '{print $2}')
export OMP_NUM_THREADS=1;export OMP_PLACES=cores;export OMP_PROC_BIND=close
. ~/epyc/spack-newpackage/share/spack/setup-env.sh
spack load hdf5 /3f3o2w6
mpiexec.openmpi --rank-by core --map-by node:PE=${OMP_NUM_THREADS} -n $(($NGROUP*$NPROCS)) ./selalib_distributed_workers_only
