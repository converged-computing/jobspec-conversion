#!/bin/bash
#SBATCH --output=unet_mid2_custom_aug_0001_2-%N-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32000M
#SBATCH --time=00:18:00

module load cuda cudnn python/3.5.2
source tensorflow6/bin/activate
python /home/rbbidart/cancer_hist/src/unet_dist_test.py /home/rbbidart/project/rbbidart/cancer_hist/full_slides2 /home/rbbidart/project/rbbidart/cancer_hist/im_dist_labels /home/rbbidart/cancer_hist_out/unet_dist/unet_mid2_custom_aug_0001_2 100 4 unet_mid2
