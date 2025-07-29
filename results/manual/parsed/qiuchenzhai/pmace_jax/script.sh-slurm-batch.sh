#!/bin/bash
#SBATCH --job-name=demo_pmace_jax
#SBATCH --account=standby
#SBATCH --output=output.out
#SBATCH --error=error.out
#SBATCH --mail-user=qzhai@purdue.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem=48G
#SBATCH --time=01:00:00

module load anaconda/2020.11-py38
module load cudnn/cuda-12.1_8.9
conda activate pmace_jax
nvidia-smi
cd tests/synthetic_image/single_mode/
nohup python noisy_data_reconstruction.py
