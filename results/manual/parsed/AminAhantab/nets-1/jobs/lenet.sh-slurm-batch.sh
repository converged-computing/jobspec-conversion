#!/bin/bash
#SBATCH --job-name=nets_lenet
#SBATCH --output=/scratch/users/%u/%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --mem=16G
#SBATCH --partition=gpu
#SBATCH --chdir=/users/k1502897/workspace/nets/

set -euxo pipefail
module load anaconda3/2021.05-gcc-10.3.0
PYTHON_BIN="/scratch/users/k1502897/conda/nets/bin/python"
$PYTHON_BIN -m imp_vs_nets.py
echo "Job finished successfully"
