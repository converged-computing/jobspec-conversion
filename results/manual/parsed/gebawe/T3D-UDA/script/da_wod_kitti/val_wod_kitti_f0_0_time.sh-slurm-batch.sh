#!/bin/bash
#SBATCH --output=/home/gebreawe/Model_logs/Segmentation/ST-UDA/logs/run_val_uda_wod_kitti_wod_f0_0_time_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:3
#SBATCH --mem=40G
#SBATCH --time=04:00:00
#SBATCH --partition=amdgpufast
#SBATCH --constraint=ntasks-per-node=3

export NCCL_LL_THRESHOLD='0'

ml spconv/2.1.21-foss-2021a-CUDA-11.3.1
ml PyTorch-Geometric/2.0.2-foss-2021a-CUDA-11.3.1-PyTorch-1.10.0
cd ../..
name=cylinder_asym_networks
export NCCL_LL_THRESHOLD=0
python test.py --config_path 'configs/data_config/da_wod_kitti/uda_wod_kitti_f0_0_time.yaml' --mode 'val' --challenge 'False' --save 'True' 2>&1 | tee logs_dir/${name}_logs_val_uda_wod_kitti_f0_0_time.txt
