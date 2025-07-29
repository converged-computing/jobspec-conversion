#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=03:30:00
#SBATCH --partition=dpart
#SBATCH --qos=medium

export WORK_DIR='/cfarhomes/psando/Documents/UAPs/gd-uap-pytorch/'

set -x
export WORK_DIR="/cfarhomes/psando/Documents/UAPs/gd-uap-pytorch/"
srun bash -c "cd ${WORK_DIR} && python3 train.py --model vgg16"
