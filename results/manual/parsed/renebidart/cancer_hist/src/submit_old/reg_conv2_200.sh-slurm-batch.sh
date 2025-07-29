#!/bin/bash
#SBATCH --output=%N-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32000M
#SBATCH --time=00:23:00

module load cuda cudnn python/3.5.2
source tensorflow/bin/activate
python /home/rbbidart/cancer_hist/src/reg_test.py project/rbbidart/cancer_hist/full_slides /home/rbbidart/cancer_hist/output/reg_conv2_200 200 8 200 conv2
