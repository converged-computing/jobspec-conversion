#!/bin/bash
#SBATCH --job-name=test
#SBATCH --output=%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=2-00:00:00
#SBATCH --partition=gpu32
#SBATCH --qos=normal

CUDA_VISIBLE_DEVICES=0 python edit_cli.py --resolution 256 --ckpt logs/train_all100kdata_add_coco_pet_seg_blue/checkpoints/epoch=000020.ckpt --input data/oxford-pets --output ./outputs/imgs_test_pets_seg/ --edit "segment the %" --task pet_seg
