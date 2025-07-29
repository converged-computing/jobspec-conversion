#!/bin/bash
#SBATCH --job-name=wi
#SBATCH --output=./wp.o
#SBATCH --error=./wp.e
#SBATCH --mail-user=318112194@qq.com
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=20000
#SBATCH --time=00:24:00
#SBATCH --partition=rtx8000,v100

cd /scratch/zt2080/shizhe/eres/transformerCVAE-origin
python train.py\
    --use_wandb\
    --iterations=25000\
    --warmup=250\
    --add_input\
    --add_attn\
    --add_softmax\
    --learn_prior\
