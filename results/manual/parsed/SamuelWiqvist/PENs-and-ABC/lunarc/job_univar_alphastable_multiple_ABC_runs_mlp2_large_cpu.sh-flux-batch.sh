#!/bin/bash
#FLUX: --job-name=univ_alphastable_multi_ABC_dnn_small2
#FLUX: --queue=lu
#FLUX: -t=361800
#FLUX: --urgency=16

ml load GCC/6.4.0-2.28
ml load OpenMPI/2.1.2
ml load julia/1.0.0
pwd
cd ..
pwd
julia /home/samwiq/'ABC and deep learning project'/abc-dl/src/'alpha stable dist'/multiple_ABC_runs_mlp.jl mlp standard 250 100 100 50 2 0 large
