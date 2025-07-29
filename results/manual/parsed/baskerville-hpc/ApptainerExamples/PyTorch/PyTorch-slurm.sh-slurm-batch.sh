#!/bin/bash
#SBATCH --job-name=nvidia-smi
#SBATCH --account=<account
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --time=00:00:30
#SBATCH --qos=<qos>

module purge
module load baskerville
module load CUDA/11.3.1 
unset APPTAINER_BIND
apptainer run --nv PyTorch.sif
