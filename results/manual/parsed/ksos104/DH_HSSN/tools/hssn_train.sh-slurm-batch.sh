#!/bin/bash
#SBATCH --output=slurm_log/%j_out.txt
#SBATCH --error=slurm_log/%j_err.txt
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2

CONFIG=configs/deeplabv3plus/deeplabv3plus_r101-d8_480x480_60k_pascal_person_part_hiera_triplet.py
GPUS=2
PORT=15346
CUDA_VISIBLE_DEVICES=6,7 python -m torch.distributed.launch --nproc_per_node=$GPUS --master_port=$PORT \
    tools/train.py $CONFIG --load-from=output_iter60k+-res101/iter_6000-74.13.pth --launcher pytorch ${@:3}
