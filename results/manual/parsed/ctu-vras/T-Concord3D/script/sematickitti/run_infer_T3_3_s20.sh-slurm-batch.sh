#!/bin/bash
#SBATCH --output=logs/semantickitti_run_test_T3_3_s20_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --mem=40G
#SBATCH --time=04:00:00
#SBATCH --partition=amdgpufast
#SBATCH --constraint=ntasks-per-node=1

ml spconv/2.1.21-foss-2021a-CUDA-11.3.1
ml PyTorch-Geometric/2.0.2-foss-2021a-CUDA-11.3.1-PyTorch-1.10.0
cd ../..
name=T-concord3D
python test.py --config_path 'config/semantickitti/semantickitti_T3_3_s20.yaml' \
--mode 'infer' --save 'True' 2>&1 | tee logs_dir/${name}_logs_test_T3_3_s20.txt
