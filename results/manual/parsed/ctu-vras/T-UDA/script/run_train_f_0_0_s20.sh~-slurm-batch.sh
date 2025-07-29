#!/bin/bash
#SBATCH --output=/home/gebreawe/Model_logs/Segmentation/Spvnas/logs/run_spvnas_f0_0_s20_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=40G
#SBATCH --time=1-00:00:00
#SBATCH --partition=amdgpu
#SBATCH --constraint=ntasks-per-node=1

cd ..
ml torchsparse/1.4.0-foss-2021a-CUDA-11.3.1
python train.py configs/semantic_kitti/spvcnn/cr0p5.yaml --distributed False --ssl False
