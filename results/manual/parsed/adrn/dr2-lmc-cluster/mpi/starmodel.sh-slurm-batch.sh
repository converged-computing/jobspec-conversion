#!/bin/bash
#SBATCH --job-name=isochrones
#SBATCH --output=isochrones.o%j
#SBATCH --error=isochrones.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --partition=cca
#SBATCH --array=0-418

LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/mnt/home/apricewhelan/software/lib/
cd /mnt/ceph/users/apricewhelan/projects/dr2-lmc-cluster/scripts
module load gcc openmpi2
date
python run_isochrones_sample.py --index=$SLURM_ARRAY_TASK_ID
date
