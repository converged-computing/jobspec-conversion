#!/bin/bash
#SBATCH --job-name=apogee-run
#SBATCH --output=logs/apogee-run.o%j
#SBATCH --error=logs/apogee-run.e%j
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-12:00:00
#SBATCH --partition=cca
#SBATCH --constraint=ntasks-per-node=56,rome

cd /mnt/ceph/users/apricewhelan/projects/apogee-dr17-binaries/simulated-test
source hq-config/init.sh
echo $HQ_RUN_PATH
date
mpirun python3 -m mpi4py.run -rc thread_level='funneled' \
$CONDA_PREFIX/bin/hq run_thejoker -v --mpi
date
