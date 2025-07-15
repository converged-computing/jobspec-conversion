#!/bin/bash
#FLUX: --job-name=delicious-poo-4200
#FLUX: --priority=16

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
