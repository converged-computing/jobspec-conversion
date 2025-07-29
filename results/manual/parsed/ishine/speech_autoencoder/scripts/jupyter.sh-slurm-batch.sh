#!/bin/bash
#SBATCH --job-name=jupyter
#SBATCH --output=/hpc/data/home/bme/guochx/jupyter.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32GB
#SBATCH --time=5-00:00:00

module load 7/compiler/cuda/11.4
source /hpc/data/home/bme/guochx/.bashrc
conda activate torch18
nvidia-smi
which python
srun jupyter notebook --no-browser --port=8888
