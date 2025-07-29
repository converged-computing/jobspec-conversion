#!/bin/bash
#SBATCH --job-name=apogee-rerun
#SBATCH --output=logs/apogee-rerun.o%j
#SBATCH --error=logs/apogee-rerun.e%j
#SBATCH --nodes=10
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-12:00:00
#SBATCH --constraint=ntasks-per-node=64,rome

cd /mnt/ceph/users/apricewhelan/projects/apogee-dr17-binaries/vac-pipeline
source hq-config/init.sh
echo $HQ_RUN_PATH
date
mpirun python3 -m mpi4py.run -rc thread_level='funneled' \
$CONDA_PREFIX/bin/hq rerun_thejoker -v --mpi
date
