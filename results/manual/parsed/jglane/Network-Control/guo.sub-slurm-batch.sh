#!/bin/bash
#SBATCH --account=guo675-h
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
module load anaconda
module load anaconda/2020.11-py38
module load cuda/11.7.0
module load cudnn/cuda-11.7_8.6
module load use.own
module load conda-env/my_tf_env-py3.8.5
python control.py
