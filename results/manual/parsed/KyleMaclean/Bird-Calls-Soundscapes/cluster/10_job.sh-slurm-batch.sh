#!/bin/bash
#SBATCH --account=cs
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:2
#SBATCH --mem=8g
#SBATCH --partition=csug

module load nvidia/cuda-11.0
module load nvidia/cudnn-v8.0.180-forcuda11.0
papermill ./10_input_fresh.ipynb ./10_input_fresh_OUT.ipynb
