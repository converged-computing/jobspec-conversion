#!/bin/bash
#SBATCH --job-name=slurm_run
#SBATCH --output=/home/n/nguyenpk/CS6220/project/NLP_DS_distance/SLURM_SCRIPT/log/%A_%a.log
#SBATCH --error=/home/n/nguyenpk/CS6220/project/NLP_DS_distance/SLURM_SCRIPT/err/err.%A_%a
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=50GB
#SBATCH --time=3-00:00:00
#SBATCH --partition=long
#SBATCH --array=0-10
#SBATCH --exclude=amdgpu1,amdgpu2,xcna0,xgpd9

ulimit -s 10240
ulimit -u 100000
srun -N 1 --ntasks-per-node=1 ./script.sh ${SLURM_ARRAY_TASK_ID} 
