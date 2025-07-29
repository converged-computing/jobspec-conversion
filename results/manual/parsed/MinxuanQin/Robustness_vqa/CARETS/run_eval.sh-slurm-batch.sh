#!/bin/bash
#SBATCH --job-name=nlp_vqa
#SBATCH --output=../logs/%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=8G
#SBATCH --time=08:00:00

module load gcc/8.2.0 python_gpu/3.10.4 cuda/11.8.0 git-lfs/2.3.0 git/2.31.1 eth_proxy
source "${SCRATCH}/.python_venv/vqa/bin/activate"
python torch_dataset.py
