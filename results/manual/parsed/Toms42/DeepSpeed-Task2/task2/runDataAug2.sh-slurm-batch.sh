#!/bin/bash
#SBATCH --output=training-outputs/hostname_%j.out
#SBATCH --error=training-outputs/hostname_%j.err
#SBATCH --mail-user=tscherli@andrew.cmu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=1000
#SBATCH --time=1-00:00:00

. /home/tscherli/.bash_profile
echo "Starting Docker Image"
pwd
docker ps
nvidia-docker ps
set -x
nvidia-docker run -v /data/datasets:/data/datasets -v /home/tscherli:/home/tscherli tscherli/alphatraining python3 /data/datasets/tscherli/task2/data_aug/augment-less.py
wait
echo "Done!"
