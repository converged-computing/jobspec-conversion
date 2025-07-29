#!/bin/bash
#SBATCH --job-name=res_train
#SBATCH --output=/scratch/yl9539/mmdetection/scripts/slurm_resnew_24_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=14
#SBATCH --gres=gpu:4
#SBATCH --mem=32GB
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
cd ../
bash ./tools/dist_train.sh ./configs/mask_rcnn/mask_rcnn_r50_fpn_1x_coco_datapath.py  4
