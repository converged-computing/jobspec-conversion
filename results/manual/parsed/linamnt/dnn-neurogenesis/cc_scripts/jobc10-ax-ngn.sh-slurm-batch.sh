#!/bin/bash
#SBATCH --job-name=c10ngn
#SBATCH --output=./output/%x-%j-%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:t4:1
#SBATCH --mem=128000M
#SBATCH --time=2-00:00:00

SOURCEDIR=~/ndl/cc_scripts
VENV=~/pytorch_gpu
module load python/3.6
source $VENV/bin/activate # virtual environment for project
mkdir $SLURM_TMPDIR/data
tar -xf ~/data/cifar10.tar -C $SLURM_TMPDIR/data
SCRIPT=c10-neurogenesis-hpt.py # script should take as an argument the data path
python $SOURCEDIR/$SCRIPT -d $SLURM_TMPDIR -s $SOURCEDIR -n 250 -t 5
