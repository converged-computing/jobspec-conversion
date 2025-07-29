#!/bin/bash
#SBATCH --job-name=ndl-pytest
#SBATCH --output=./output/%x-%j-%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:t4:1
#SBATCH --mem=32000M
#SBATCH --time=00:20:00

SOURCEDIR=~/ndl
VENV_DIR=~/pytorch_gpu
module load python/3.6
source $VENV_DIR/bin/activate # virtual environment for project
cd $SOURCEDIR
pytest 
