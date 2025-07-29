#!/bin/bash
#SBATCH --output=%x.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=a100:1
#SBATCH --mem=64gb
#SBATCH --time=04:00:00
#SBATCH --partition=gpu

date;hostname;pwd
module load singularity
singularity exec --nv \
--bind /blue/vendor-nvidia/hju/data/swinunetr_pretrain_CT:/mnt \
/blue/vendor-nvidia/hju/monaicore0.9.1 \
python main.py \
--roi_x=128 --roi_y=128 --roi_z=128 \
--lrdecay --lr=6e-6 \
--batch_size=1 \
--epochs=3 --num_steps=6 --eval_num=2 \
--noamp
