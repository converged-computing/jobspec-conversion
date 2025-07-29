#!/bin/bash
#SBATCH --output=logs/run_train_T3_3_s20_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --mem=40G
#SBATCH --time=3-00:00:00
#SBATCH --partition=amdgpulong
#SBATCH --constraint=ntasks-per-node=1

ml spconv/2.1.21-foss-2021a-CUDA-11.3.1
ml PyTorch-Geometric/2.0.2-foss-2021a-CUDA-11.3.1-PyTorch-1.10.0
cd ../..
name=T-Concord3D
python train.py --config_path 'config/semantickitti/semantickitti_T3_3_s20.yaml' 2>&1 \
| tee logs_dir/${name}_logs_tee_T3_3_s20.txt
