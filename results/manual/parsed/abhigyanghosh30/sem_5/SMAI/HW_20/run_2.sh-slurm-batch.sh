#!/bin/bash
#SBATCH --account=RESEARCH
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --mem-per-cpu=2048
#SBATCH --time=1-00:00:00

module add cuda/10.0
module add cudnn/7-cuda-10.0
python 2.py 1 0 &
python 2.py 2 1 &
python 2.py 3 1 &
python 2.py 0 0
