#!/bin/bash
#SBATCH --output=/home/gebreawe/Model_logs/Segmentation/T-UDA/logs/synthetic_train_f2_2_time_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --gres=gpu:1
#SBATCH --mem=60G
#SBATCH --time=04:00:00
#SBATCH --partition=amdgpufast
#SBATCH --constraint=ntasks-per-node=1

export NCCL_LL_THRESHOLD='0'

ml spconv/2.1.21-foss-2021a-CUDA-11.3.1
ml PyTorch-Geometric/2.0.2-foss-2021a-CUDA-11.3.1-PyTorch-1.10.0
cd ../..
name=cylinder_asym_networks
export NCCL_LL_THRESHOLD=0
echo "epoch 0"
python train_uda.py --config_path 'configs/data_config/synthetic/synth4dsynth_f3_3_time.yaml' 2>&1 | tee logs_dir/${name}_logs_synth4dsynth_f3_3_time.txt
