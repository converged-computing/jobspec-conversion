#!/bin/bash
#SBATCH --job-name=GTrack-train
#SBATCH --account=m3443
#SBATCH --output=logs/%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gpus-per-task=1
#SBATCH --time=06:00:00
#SBATCH --partition=regular
#SBATCH --constraint=gpu,ntasks-per-node=4

export SLURM_CPU_BIND='cores'

mkdir -p logs
eval "$(conda shell.bash hook)"
source activate gtrack
export SLURM_CPU_BIND="cores"
echo -e "\nStarting training\n"
srun -u python run.py $@
