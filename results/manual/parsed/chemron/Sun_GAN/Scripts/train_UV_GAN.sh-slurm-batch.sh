#!/bin/bash
#SBATCH --job-name=train_P100
#SBATCH --mail-user=csmi0005@student.monash.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:P100:1
#SBATCH --mem=10G
#SBATCH --time=4-04:00:00
#SBATCH --partition=gpu

module load anaconda/5.1.0-Python3.6-gcc5
module load cudnn/7.6.5-cuda10.1
module load tensorflow/2.3.0
python Training/train.py \
    --model_name "UV_GAN_1" \
    --display_iter 50000 \
    --max_iter 500000 \
    --batch_size 1 \
    --tol 3 \
    --input "aia.np_path_normal" \
    --output "hmi.np_path_normal" \
    --connector "aia.id" "hmi.aia_id" \
