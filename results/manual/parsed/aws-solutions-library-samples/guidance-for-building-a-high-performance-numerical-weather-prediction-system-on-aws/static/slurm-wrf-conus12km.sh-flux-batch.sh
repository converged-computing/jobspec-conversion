#!/bin/bash
#FLUX: --job-name=WRF
#FLUX: -N=2
#FLUX: -c=2
#FLUX: --exclusive
#FLUX: --urgency=16

export OMP_NUM_THREADS='2'
export FI_PROVIDER='efa'
export KMP_AFFINITY='compact'

spack load wrf
module load libfabric-aws
wrf_exe=$(spack location -i wrf)/run/wrf.exe
set -x
ulimit -s unlimited
ulimit -a
export OMP_NUM_THREADS=2
export FI_PROVIDER=efa
export KMP_AFFINITY=compact
echo " Will run the following command: time mpirun --report-bindings --bind-to core --map-by slot:pe=${OMP_NUM_THREADS} $wrf_exe"
time mpirun --report-bindings --bind-to core --map-by slot:pe=${OMP_NUM_THREADS} $wrf_exe
