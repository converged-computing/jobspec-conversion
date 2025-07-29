#!/bin/bash
#SBATCH --output=/home/gebreawe/Code/Segmentation/T-UDA/logs/train_uda_nuscenes_wod_T1_1_S0_0_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --gres=gpu:1
#SBATCH --mem=60G
#SBATCH --time=10-00:00:00
#SBATCH --constraint=ntasks-per-node=1

cd ../..
ml torchsparse/1.4.0-foss-2021a-CUDA-11.3.1
python train_uda.py configs/data_config/da_wod_nuscenes/uda_nuscenes_wod.yaml --distributed False --ssl False
