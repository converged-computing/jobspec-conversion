#!/bin/bash
#SBATCH --job-name=DL4N_full_prod
#SBATCH --account=m2043_g
#SBATCH --output=logs/%A_%a
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --partition=regular
#SBATCH --constraint=gpu
#SBATCH --array=1-1
#SBATCH --licenses=SCRATCH,cfs

singularity
exec
nersc/pytorch:ngc-21.08-v2
data_path=/pscratch/sd/k/ktub1999/bbp_May_18_8944917/
srun -n 1 shifter python3 Ntran2.py --data_path $data_path
