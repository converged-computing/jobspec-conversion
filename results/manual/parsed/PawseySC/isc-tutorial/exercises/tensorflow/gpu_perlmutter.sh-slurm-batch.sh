#!/bin/bash
#SBATCH --job-name=tf_distributed
#SBATCH --account=<NERSC-project>
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=4
#SBATCH --time=01:00:00
#SBATCH --qos=regular
#SBATCH --constraint=gpu

theImage="nvcr.io/nvidia/tensorflow:22.04-tf2-py3"
shifterimg pull $theImage
theScript="distributedMNIST.py"
srun shifter --image="$theImage" python $theScript
