#!/bin/bash
#SBATCH --job-name=tf_distributed
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:2
#SBATCH --time=01:00:00

theImage="docker://nvcr.io/nvidia/tensorflow:22.04-tf2-py3"
module load singularity
theScript="distributedMNIST.py"
srun singularity exec --nv -e -B fake_home:$HOME $theImage python $theScript
