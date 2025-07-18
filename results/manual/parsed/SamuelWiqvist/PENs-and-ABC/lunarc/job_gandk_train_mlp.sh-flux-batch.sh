#!/bin/bash
#FLUX: --job-name=gandk_train_mlp
#FLUX: --queue=gpu
#FLUX: -t=16200
#FLUX: --urgency=16

ml load GCC/6.4.0-2.28
ml load CUDA/9.1.85
ml load OpenMPI/2.1.2
ml load cuDNN/7.0.5.15
ml load julia/1.0.0
nvidia-smi
pwd
cd ..
pwd
julia /home/samwiq/'ABC and deep learning project'/abc-dl/src/'g and k dist'/train_mlp_network.jl mlp_small standard 250 25 25 12 1 1
