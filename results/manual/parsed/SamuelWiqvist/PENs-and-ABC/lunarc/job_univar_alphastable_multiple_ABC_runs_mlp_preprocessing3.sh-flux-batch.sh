#!/bin/bash
#FLUX: --job-name=univ_alphastable_multi_ABC_mlp_preprocessing3
#FLUX: --queue=gpu
#FLUX: -t=360000
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
julia /home/samwiq/'ABC and deep learning project'/abc-dl/src/'alpha stable dist'/multiple_ABC_runs_mlp_preprocessing.jl standard 250 100 100 50 3 0
