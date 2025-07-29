#!/bin/bash
#SBATCH --job-name=tf_distributed
#SBATCH --account=nstaff
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=4
#SBATCH --time=00:30:00
#SBATCH --qos=debug
#SBATCH --constraint=gpu

singularity
exec
nvcr.io/nvidia/tensorflow:22.04-tf2-py3
theScript="distributedMNIST.py"
srun shifter python $theScript
