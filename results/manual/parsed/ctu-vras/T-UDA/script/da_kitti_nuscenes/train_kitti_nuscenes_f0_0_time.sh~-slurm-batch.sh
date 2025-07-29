#!/bin/bash
#SBATCH --output=/home/gebreawe/Model_logs/Segmentation/ST-SPVNAS/logs/train_uda_kitti_nuscenes_T0_0_S0_0_time_intensity_uda%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --gres=gpu:1
#SBATCH --mem=60G
#SBATCH --time=10-00:00:00
#SBATCH --partition=amdgpuextralong
#SBATCH --constraint=ntasks-per-node=1

cd ../..
ml torchsparse/1.4.0-foss-2021a-CUDA-11.3.1
python train_uda.py configs/data_config/da_kitti_nuscenes/uda_kitti_nuscenes_f0_0_time.yaml --distributed False --ssl False
