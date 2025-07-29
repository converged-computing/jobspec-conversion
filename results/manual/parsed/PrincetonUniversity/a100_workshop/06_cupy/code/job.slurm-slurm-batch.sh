#!/bin/bash
#SBATCH --job-name=cupy
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=128G
#SBATCH --time=00:01:00
#SBATCH --constraint=v100

module purge
module load anaconda3/2022.5
conda activate /scratch/network/jdh4/.gpu_workshop/envs/cupy-env
echo "GPU is " $(nvidia-smi -a | grep "Product Name" | awk '{print $(NF)}')
python myscript.py               # case 1
