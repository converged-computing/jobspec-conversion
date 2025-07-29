#!/bin/bash
#SBATCH --output=logs/run_infer_S0_0_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:1
#SBATCH --mem=80G
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=1

ml spconv/2.1.21-foss-2021a-CUDA-11.3.1
ml PyTorch-Geometric/2.0.2-foss-2021a-CUDA-11.3.1-PyTorch-1.10.0
cd ../..
name=T-Concord3D
python3 test.py --config_path 'config/semantickitti/semantickitti_T0_0.yaml' \
--mode 'infer' --save 'True' 2>&1 | tee logs_dir/${name}_logs_val_f0_0.txt
