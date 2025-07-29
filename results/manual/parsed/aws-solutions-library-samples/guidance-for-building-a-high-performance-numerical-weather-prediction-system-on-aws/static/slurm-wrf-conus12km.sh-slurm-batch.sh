#!/bin/bash
#SBATCH --job-name=WRF
#SBATCH --output=conus-%j.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=48

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
