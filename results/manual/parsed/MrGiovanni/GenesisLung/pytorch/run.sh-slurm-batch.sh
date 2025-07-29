#!/bin/bash
#SBATCH --mail-user=zzhou82@asu.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=03:50:00

module load anaconda/py3
source /data/jliang12/zzhou82/environments/pytorch/bin/activate
nvidia-smi
python -W ignore genesis_lung.py --data $1 --weights $2
