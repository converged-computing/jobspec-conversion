#!/bin/bash
#SBATCH --job-name=molecule
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=1-23:30:00
#SBATCH --partition=amd_a100_4

source /home01/$USER/.bashrc
module purge
module load singularity/3.9.7
module load htop nvtop
module load gcc/10.2.0
module load cuda/10.2
module list
conda activate mxmnet
cd /scratch/$USER/workspace/MXMNet
echo "START"
srun python main.py
echo "DONE"
