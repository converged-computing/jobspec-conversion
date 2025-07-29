#!/bin/bash
#SBATCH --job-name=apogee-setup
#SBATCH --output=logs/apogee-setup.o%j
#SBATCH --error=logs/apogee-setup.e%j
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --constraint=rome

cd /mnt/ceph/users/apricewhelan/projects/apogee-dr17-binaries/vac-pipeline
source hq-config/init.sh
echo $HQ_RUN_PATH
date
mpirun python3 -m mpi4py.run -rc thread_level='funneled' \
$CONDA_PREFIX/bin/hq make_prior_cache -v --mpi
hq make_tasks -v
date
