#!/bin/bash
#SBATCH --mail-user=zzhou82@asu.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:10:00
#SBATCH --partition=wildfire

module load tensorflow/1.8-agave-gpu                                            
module unload python/.2.7.14-tf18-gpu
/packages/7x/python/3.6.5-tf18-gpu/bin/python3 -m pip install --upgrade pip --user
python3.6 -W ignore main.py --run $1 --task $2 --partial $3 --init $4 --act $5
