#!/bin/bash
#SBATCH --job-name=poi_adam
#SBATCH --output=./stdout_%J
#SBATCH --error=./stderr_%J
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --gpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=amdrome
#SBATCH --nodelist=amd1

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
ROCR_VISIBLE_DEVICES=1,2,3 srun ../build/miniapps/heat3d/thrust/heat3d --nx 512 --ny 512 --nz 512 --nbiter 1000 --freq_diag 0
