#!/bin/bash
#SBATCH --output=logs/run_train_T0_0_s20_t2_%j.log
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
python train_tconcord3d.py --config_path 'config/semantickitti/semantickitti_T0_0.yaml' \
2>&1 | tee logs_dir/${name}_logs_tee_T0_0.txt
