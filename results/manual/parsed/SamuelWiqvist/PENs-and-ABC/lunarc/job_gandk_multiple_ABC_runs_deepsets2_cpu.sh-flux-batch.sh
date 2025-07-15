#!/bin/bash
#FLUX: --job-name=placid-truffle-6905
#FLUX: --priority=16

ml load GCC/6.4.0-2.28
ml load OpenMPI/2.1.2
ml load julia/1.0.0
pwd
cd ..
pwd
julia /home/samwiq/'ABC and deep learning project'/abc-dl/src/'g and k dist'/multiple_ABC_runs_deepsets.jl standard 250 2 0
