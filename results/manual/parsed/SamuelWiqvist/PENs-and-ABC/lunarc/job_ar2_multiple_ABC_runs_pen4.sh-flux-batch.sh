#!/bin/bash
#FLUX: --job-name=boopy-house-0735
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
julia /home/samwiq/'ABC and deep learning project'/abc-dl/src/AR2/multiple_ABC_runs_pen.jl standard 250 4 0
