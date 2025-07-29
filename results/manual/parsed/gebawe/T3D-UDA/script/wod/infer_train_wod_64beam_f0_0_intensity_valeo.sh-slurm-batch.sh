#!/bin/bash
#SBATCH --output=/home/gebreawe/Model_logs/Segmentation/ST-UDA/logs/wod_64beam_infer_train_f0_0_intensity_valeo%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --gres=gpu:1
#SBATCH --mem=60G
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=1

export NCCL_LL_THRESHOLD='1'

ml spconv/2.1.21-foss-2021a-CUDA-11.3.1
ml PyTorch-Geometric/2.0.2-foss-2021a-CUDA-11.3.1-PyTorch-1.10.0
cd ../..
name=cylinder_asym_networks
export NCCL_LL_THRESHOLD=1
python test_wod.py --config_path 'configs/wod/wod_f0_0_intensity.yaml' --mode 'test' --save 'True' 2>&1 | tee logs_dir/${name}_logs_wod_64beam_f0_0_intensity_infer_train_v3_2_valeo.txt
