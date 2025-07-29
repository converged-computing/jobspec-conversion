#!/bin/bash
#FLUX: --job-name=gandk_multi_ABC_mlp
#FLUX: --queue=lu
#FLUX: -t=361800
#FLUX: --urgency=16

ml load GCC/6.4.0-2.28
ml load OpenMPI/2.1.2
ml load julia/1.0.0
pwd
cd ..
pwd
julia /home/samwiq/'ABC and deep learning project'/abc-dl/src/'g and k dist'/multiple_ABC_runs_mlp.jl mlp standard 500 100 100 50 1 0 large
