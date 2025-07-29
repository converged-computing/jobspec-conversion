#!/bin/bash
#SBATCH --account=def-rnoumeir
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --gres=gpu:1
#SBATCH --mem=64000M
#SBATCH --time=12:00:00

module restore tensorenvironment
SOURCEDIR=~/scratch/Pointnet
source ~/Workspace/TensorFlowEnvironment/bin/activate
tensorboard --logdir=./logs --host 0.0.0.0 --load_fast false & python $SOURCEDIR/train.py
