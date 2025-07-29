#!/bin/bash
#SBATCH --output=/home/gebreawe/Model_logs/Segmentation/T-UDA/logs/train_uda_nuscenes_wod_f2_0_time_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --gres=gpu:1
#SBATCH --mem=60G
#SBATCH --time=10-00:00:00
#SBATCH --constraint=ntasks-per-node=1

export NCCL_LL_THRESHOLD='0'

ml spconv/2.1.21-foss-2021a-CUDA-11.3.1
ml PyTorch-Geometric/2.0.2-foss-2021a-CUDA-11.3.1-PyTorch-1.10.0
cd ../..
name=t-uda
export NCCL_LL_THRESHOLD=0
echo "epoch 0"
python train_uda.py --config_path 'configs/data_config/da_wod_nuscenes/uda_nuscenes_wod_f2_0_time.yaml' 2>&1 | tee logs_dir/${name}_uda_nuscenes_wod_f2_0_time.txt
