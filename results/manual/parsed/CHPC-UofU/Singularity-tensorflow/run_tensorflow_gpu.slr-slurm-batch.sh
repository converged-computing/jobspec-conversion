#!/bin/bash
#SBATCH --account=kingspeak-gpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:k80:1
#SBATCH --time=00:10:00

nvidia-smi
ml purge
ml tensorflow/1.0.1.gpu
cd /uufs/chpc.utah.edu/common/home/u0101881/containers/singularity/containers/chpc/tensorflow/example
tensorflow-gpu helloworld.py
