#!/bin/bash
#SBATCH --job-name=hpml
#SBATCH --output=pytorch_resnet34.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32GB
#SBATCH --time=03:00:00

module purge
module load anaconda3/2020.07
eval "$(conda shell.bash hook)"
conda activate assignment
/scratch/pp2603/envs_dirs/assignment/bin/python main.py --workers=4 --batchsize=128 --cuda --optimizer="SGD"
