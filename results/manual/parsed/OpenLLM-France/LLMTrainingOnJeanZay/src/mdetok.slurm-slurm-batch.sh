#!/bin/bash
#SBATCH --job-name=megatrondetok
#SBATCH --account=knb@a100
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --time=00:50:00
#SBATCH --qos=qos_gpu-dev
#SBATCH --constraint=ntasks-per-node=1,a100

export HOME='$WORK"/home/'

export HOME=$WORK"/home/"
module load anaconda-py3/2023.09
conda activate megatron
module load cpuarch/amd
set -x
echo "DATEDEBUT"
date
srun python mdetok.py
