#!/bin/bash
#SBATCH --job-name=unet_train_1
#SBATCH --output=/scratch/%u/%x-%N-%j.out
#SBATCH --error=/scratch/%u/%x-%N-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem=64G
#SBATCH --time=00:08:00
#SBATCH --qos=gpu

echo  "$(which singularity)"
singularity instance start --nv -B /home/mle35:/home/mle35,/scratch/mle35:/scratch/mle35  /home/mle35/rapidsai.sif rapids
cd /home/mle35/nga-deep-learning/scripts
singularity run instance://rapids python train.py 
