#!/bin/bash
#SBATCH --job-name=resnet_multi_ncl_1
#SBATCH --output=%x_%j_output.log
#SBATCH --error=%x_%j_error.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=32GB
#SBATCH --time=7-00:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=GPURAM_Min_16GB

source /etc/profile.d/conda.sh
conda activate ecapa_tdnn
python3 trainRESNETModelMulti_ncl_1.py
conda deactivate
