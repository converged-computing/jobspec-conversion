#!/bin/bash
#SBATCH --output=training-outputs/hostname_%j.out
#SBATCH --error=training-outputs/hostname_%j.err
#SBATCH --mail-user=tscherli@andrew.cmu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem=20000
#SBATCH --time=1-00:00:00
#SBATCH --nodelist=bender

. /home/tscherli/.bash_profile
echo "Starting Docker Image"
pwd
docker ps
nvidia-docker ps
set -x
nvidia-docker run -v /data/datasets:/data/datasets -v /home/tscherli:/home/tscherli tscherli/alphatraining python3 /data/datasets/tscherli/task2/train/basic3.py &
wait
echo "Done!"
