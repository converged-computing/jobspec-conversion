#!/bin/bash
#SBATCH --job-name=jupyter
#SBATCH --output=logger-%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --mem=8G
#SBATCH --partition=student
#SBATCH --qos=quick

export PYTHONPATH='$PYTHONPATH:$PWD'

cd $HOME/vqa || exit
export PYTHONPATH=.:$PYTHONPATH
export PYTHONPATH=$PYTHONPATH:$PWD
singularity exec \
  --nv \
  -B .:/app \
  -B /shared/sets/datasets:/shared/sets/datasets \
  -B ~/.local/share:/.local/share /shared/sets/singularity/miniconda_pytorch_py310.sif \
  bash scripts/jupyter.sh
exit 0
