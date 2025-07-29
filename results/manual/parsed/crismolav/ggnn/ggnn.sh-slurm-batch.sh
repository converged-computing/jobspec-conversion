#!/bin/bash
#SBATCH --job-name=task1
#SBATCH --output=/homedtic/cmorales/log2/%N.%J.task1.out
#SBATCH --error=/homedtic/cmorales/log2/%N.%J.task1.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=100G
#SBATCH --partition=high
#SBATCH --chdir=/homedtic/cmorales

export PATH='$HOME/project/anaconda3/bin:$PATH'

export PATH="$HOME/project/anaconda3/bin:$PATH"
source activate tfgpu
cd /homedtic/cmorales/cmol/ggnn
python tf2/chem_tensorflow_dense.py $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11}
