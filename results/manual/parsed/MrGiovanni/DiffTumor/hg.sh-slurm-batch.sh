#!/bin/bash
#SBATCH --job-name=install
#SBATCH --output=%x_slurm_%j.out
#SBATCH --error=%xslurm_%j.err
#SBATCH --mail-user=zzhou82@asu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=80G
#SBATCH --time=00:30:00
#SBATCH --partition=public

module load mamba/latest # only for Sol
source activate difftumor
pip install torch==1.12.1+cu113 torchvision==0.13.1+cu113 torchaudio==0.12.1 --extra-index-url https://download.pytorch.org/whl/cu113
pip install -r requirements.txt
