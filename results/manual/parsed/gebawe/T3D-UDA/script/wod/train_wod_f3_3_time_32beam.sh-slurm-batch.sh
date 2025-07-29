#!/bin/bash
#SBATCH --output=/home/gebreawe/Model_logs/Segmentation/ST-UDA/logs/wod_train_f3_3_all_v3_2_time_beam32_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --gres=gpu:1
#SBATCH --mem=60G
#SBATCH --time=21-00:00:00
#SBATCH --partition=amdgpuextralong
#SBATCH --constraint=ntasks-per-node=1

export NCCL_LL_THRESHOLD='0'

ml spconv/2.1.21-foss-2021a-CUDA-11.3.1
ml PyTorch-Geometric/2.0.2-foss-2021a-CUDA-11.3.1-PyTorch-1.10.0
cd ../..
name=cylinder_asym_networks
export NCCL_LL_THRESHOLD=0
echo "epoch 0"
python train.py --config_path 'configs/wod/wod_f3_3_time_beam32.yaml' 2>&1 | tee logs_dir/${name}_logs_wod_f3_3_b2_v3_2_time_beam32.txt
