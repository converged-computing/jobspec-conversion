#!/bin/bash
#SBATCH --job-name=gan_anime
#SBATCH --account=iit111
#SBATCH --output=keras.%j.%N.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=6

module load singularity # load the singularity module
singularity exec --nv /share/apps/gpu/singularity/images/keras/keras-v2.2.4-tensorflow-v1.12-gpu-20190214.simg python3 DCGAN.py
