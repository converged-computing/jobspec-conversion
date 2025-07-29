#!/bin/bash
#SBATCH --output=logs/%j.out
#SBATCH --error=logs/%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=50G
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=4

ml PyTorch3D/0.7.1-foss-2021b-CUDA-11.4.1
ml OpenCV/4.5.5-foss-2021b-CUDA-11.4.1-contrib
cd $HOME
python -u motion_supervision/run_test.py
