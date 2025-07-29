#!/bin/bash
#SBATCH --job-name=gandk_mlp_preprocessing
#SBATCH --account=lu2018-2-22
#SBATCH --output=lunarc_output/gandk/outputs_gandk_mlp_preprocessing_%j.out
#SBATCH --error=lunarc_output/gandk/errors_gandk_mlp_preprocessing_%j.err
#SBATCH --mail-user=samuel.wiqvist@matstat.lu.se
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=11000
#SBATCH --time=05:00:00

ml load GCC/6.4.0-2.28
ml load CUDA/9.1.85
ml load OpenMPI/2.1.2
ml load cuDNN/7.0.5.15
ml load julia/1.0.0
nvidia-smi
pwd
cd ..
pwd
julia /home/samwiq/'ABC and deep learning project'/abc-dl/src/'g and k dist'/train_mlp_preprocessing.jl standard 250 100 100 50 1 1
