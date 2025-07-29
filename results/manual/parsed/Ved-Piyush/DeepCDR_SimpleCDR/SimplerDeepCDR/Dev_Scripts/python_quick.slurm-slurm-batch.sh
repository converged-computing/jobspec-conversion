#!/bin/bash
#SBATCH --job-name=enkf_4
#SBATCH --output=enkf_4.%J.out
#SBATCH --error=enkf_4.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=220gb
#SBATCH --time=2-00:30:00
#SBATCH --constraint=gpu_80gb

pwd
source activate tensorflow-gpu-2.9-custom
python simplecdr_gcn.py
