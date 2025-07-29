#!/bin/bash
#SBATCH --mail-user=zzhou82@asu.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=03:50:00
#SBATCH --partition=wildfire

module load tensorflow/1.8-agave-gpu                                            
module unload python/.2.7.14-tf18-gpu
/packages/7x/python/3.6.5-tf18-gpu/bin/python3 -m pip install --upgrade pip --user
/packages/7x/python/3.6.5-tf18-gpu/bin/python3 -m pip install --upgrade pylibjpeg pylibjpeg-libjpeg pydicom --user
python3.6 -W ignore genesis_lung.py --data $1 --weights $2
