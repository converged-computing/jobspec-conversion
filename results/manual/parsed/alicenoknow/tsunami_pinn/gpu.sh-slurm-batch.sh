#!/bin/bash
#SBATCH --job-name=an-pinn-test-relo
#SBATCH --account=plghailcanoon-gpu
#SBATCH --output=slurm/output4.out
#SBATCH --error=slurm/error4.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --mem=30G
#SBATCH --time=05:00:00

module load cuda
cd $SLURM_SUBMIT_DIR
nvidia-smi
