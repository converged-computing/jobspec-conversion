#!/bin/bash
#SBATCH --job-name=ds_bloom
#SBATCH --account=knb@a100
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:2
#SBATCH --time=00:50:00
#SBATCH --qos=qos_gpu-dev
#SBATCH --constraint=ntasks-per-node=2,a100

export HOME='$WORK"/home/'

export HOME=$WORK"/home/"
. $HOME/envs/ds/bin/activate
module load cpuarch/amd
module load pytorch-gpu/py3/2.2.0
set -x
echo "DATEDEBUT"
date
srun python dsbloom.py
