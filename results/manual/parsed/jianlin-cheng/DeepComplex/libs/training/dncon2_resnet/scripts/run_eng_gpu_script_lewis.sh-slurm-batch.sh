#!/bin/bash
#SBATCH --job-name=VB3D-GPU
#SBATCH --account=engineering-gpu
#SBATCH --mail-user=nax35@mail.missouri.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:Tesla V100-PCIE-32GB:1
#SBATCH --mem=128G
#SBATCH --time=00:04:00

echo "### Starting at: $(date) ###"
module load gcc/gcc-5.4.0
module load eigen/eigen-3.2.7
module load cuda/cuda-10.0.130
source ~/.bashrc
./bin/linux/ReconParallelPipeline_MU_VB3D ./configs/albuquerque.txt
