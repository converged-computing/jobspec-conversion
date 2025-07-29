#!/bin/bash
#SBATCH --job-name=snakemake
#SBATCH --output=logs/%j.job
#SBATCH --error=logs/%j.job
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=16G
#SBATCH --time=06:00:00
#SBATCH --qos=low
#SBATCH --exclude=supergpu05,supergpu07,supergpu08

sbatch --wait <<- EOF
mkdir logs
source $HOME/.bashrc
conda activate prismnet
python -u ../../methods/PrismNet/main.py --train --eval --lr 0.001 --data_dir $1 --p_name all.train --out_dir $1
EOF
