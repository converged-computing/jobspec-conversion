#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --mem=12000
#SBATCH --time=7-00:00:00
#SBATCH --partition=cor,general
#SBATCH --qos=long

module use /opt/insy/modulefiles
module load cuda/11.2
module load miniconda
module load devtoolset/10 # newest version of gcc / g++
conda activate rsl-solving-occlusion
which python
nvidia-smi
python -u main.py $1
conda deactivate
