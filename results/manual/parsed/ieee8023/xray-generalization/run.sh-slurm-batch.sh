#!/bin/bash
#SBATCH --account=rpp-bengioy
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=12g
#SBATCH --time=10:00:00
#SBATCH --constraint=ntasks-per-node=8

export LANG='C.UTF-8'

hostname
export LANG=C.UTF-8
source $HOME/.bashrc
python3 -u train-joe.py --threads=8 $@
