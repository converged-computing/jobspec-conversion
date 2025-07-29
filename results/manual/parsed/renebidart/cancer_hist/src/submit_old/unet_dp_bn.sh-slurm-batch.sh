#!/bin/bash
#SBATCH --output=%N-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32000M
#SBATCH --time=00:24:00

module load cuda cudnn python/3.5.2
source tensorflow/bin/activate
python /home/rbbidart/cancer_hist/src/unet_model_test.py project/rbbidart/cancer_hist/full_slides/ project/rbbidart/cancer_hist/pixel_labels_r10 /home/rbbidart/cancer_hist/output/unet_dp_bn 100 2 unet_dp_bn .00005
