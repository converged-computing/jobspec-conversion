#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:1
#SBATCH --time=4-00:00:00
#SBATCH --partition=research

module load nvidia/cuda/11.3
python setup.py build_ext --inplace
python train_joint.py -c configs/joint/$1.yaml -n $2 -g $3
