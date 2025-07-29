#!/bin/bash
#SBATCH --job-name=snakemake
#SBATCH --output=logs/%j.job
#SBATCH --error=logs/%j.job
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=15G
#SBATCH --time=06:00:00
#SBATCH --qos=low

sbatch --wait << EOF
source $HOME/.bashrc
conda activate rnaprotenv
rnaprot train --in $1 --out $1 --use-eia --use-phastcons --use-phylop --verbose-train
EOF
