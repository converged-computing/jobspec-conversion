#!/bin/bash
#SBATCH --job-name=dino_neps_linear_eval_finetuning
#SBATCH --output=/work/dlclarge2/ferreira-dino/metassl-dino/experiments/dino/dino_neps_11_05_2022_distributed_fix/config_8_2_linear_eval/%x.%A.%a.%N.err_out
#SBATCH --error=/work/dlclarge2/ferreira-dino/metassl-dino/experiments/dino/dino_neps_11_05_2022_distributed_fix/config_8_2_linear_eval/%x.%A.%a.%N.err_out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:8
#SBATCH --time=5-23:59:59
#SBATCH --partition=mldlc_gpu-rtx2080

source /home/ferreira/.profile
source activate dino
pip show neps
python -m eval_linear.py --arch vit_small --data_path /data/datasets/ImageNet/imagenet-pytorch/train --output_dir /work/dlclarge2/ferreira-dino/metassl-dino/experiments/dino/dino_neps_11_05_2022_distributed_fix/config_8_2_linear_eval --batch_size_per_gpu 40 --epochs 100 --pretrained_weights /work/dlclarge2/ferreira-dino/metassl-dino/experiments/dino/dino_neps_11_05_2022_distributed_fix/config_8_2_linear_eval/checkpoint.pth
