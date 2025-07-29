#!/bin/bash
#SBATCH --output=slurm.%j.out
#SBATCH --error=slurm.%j.err
#SBATCH --mail-user=u16ak20@abdn.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --mem=20G
#SBATCH --time=6-06:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --nodelist=gpu02

nvidia-smi
conda init
module load miniconda3
conda activate testenv
which python
python --version
srun /home/u16ak20/.conda/envs/testenv/bin/python linear_evaluation.py
