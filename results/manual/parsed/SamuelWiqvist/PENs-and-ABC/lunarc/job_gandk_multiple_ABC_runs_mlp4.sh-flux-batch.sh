#!/bin/bash
#FLUX: --job-name=gandk_multi_ABC_mlp4
#FLUX: --queue=gpu
#FLUX: -t=361800
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
julia /home/samwiq/'ABC and deep learning project'/abc-dl/src/'g and k dist'/multiple_ABC_runs_mlp.jl mlp standard 50 25 25 12 4 0 small
