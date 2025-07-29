#!/bin/bash
#SBATCH --job-name=apogee-expand
#SBATCH --output=logs/expand.o%j
#SBATCH --error=logs/expand.e%j
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --partition=cca
#SBATCH --constraint=skylake

source ~/.bash_profile
init_conda
cd /mnt/ceph/users/apricewhelan/projects/hq/scripts
conda activate hq
date
mpirun -n $SLURM_NTASKS python3 expand_samples.py --name $HQ_RUN -v --mpi
cd /mnt/ceph/users/apricewhelan/projects/hq/cache/$HQ_RUN
tar -czf samples.tar.gz samples/
date
