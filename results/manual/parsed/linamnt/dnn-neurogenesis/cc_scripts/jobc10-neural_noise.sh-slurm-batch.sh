#!/bin/bash
#SBATCH --job-name=c10-noise
#SBATCH --output=./output/%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:t4:1
#SBATCH --mem=128000M
#SBATCH --time=00:09:30

SOURCEDIR=~/ndl/cc_scripts
VENV_DIR=~/pytorch_gpu
module load python/3.6
source $VENV_DIR/bin/activate # virtual environment for project
mkdir $SLURM_TMPDIR/data
tar -xf ~/data/cifar10.tar -C $SLURM_TMPDIR/data
SCRIPT=c10-neural_noise.py # script should take as an argument the data path
python $SOURCEDIR/$SCRIPT -d $SLURM_TMPDIR/data -s $SOURCEDIR 
