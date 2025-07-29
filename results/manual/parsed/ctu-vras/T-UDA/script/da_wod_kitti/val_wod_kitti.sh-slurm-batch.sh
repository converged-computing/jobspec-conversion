#!/bin/bash
#SBATCH --output=/home/gebreawe/Code/Segmentation/T-UDA/logs/val_uda_wod_kitti_T1_1_S0_0_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=40G
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=1

cd ../..
ml torchsparse/1.4.0-foss-2021a-CUDA-11.3.1
python evaluate_uda.py configs/data_config/da_wod_kitti/uda_wod_kitti.yaml --network student
