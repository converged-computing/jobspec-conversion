#!/bin/bash
#SBATCH --job-name=test
#SBATCH --mail-user=dmanningcoe@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=04:00:00
#SBATCH --partition=secondary-eth
#SBATCH --array=0-1

module load anaconda/2023-Mar/3
module load cuda/11.7
nvcc --version
nvidia-smi
source activate pytorch_one
python Ising_seed.py ${SLURM_ARRAY_TASK_ID}
