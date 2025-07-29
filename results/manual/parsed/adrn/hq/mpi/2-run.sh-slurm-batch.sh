#!/bin/bash
#SBATCH --job-name=apogee-run
#SBATCH --output=logs/apogee-run.o%j
#SBATCH --error=logs/apogee-run.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=640
#SBATCH --cpus-per-task=1
#SBATCH --time=3-00:00:00
#SBATCH --partition=cca
#SBATCH --constraint=skylake

source ~/.bash_profile
init_conda
conda activate hq
echo $HQ_RUN
cd /mnt/ceph/users/apricewhelan/projects/hq/scripts
date
mpirun -n $SLURM_NTASKS python3 run_apogee.py --name $HQ_RUN --mpi -v
date
