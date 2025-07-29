#!/bin/bash
#SBATCH --job-name=Pysster-snakemake
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
conda activate pysster-same-padding
python scripts/train_Pysster.py --params $1 --save-model-only -o $2 --in-fasta $3 $4
EOF
