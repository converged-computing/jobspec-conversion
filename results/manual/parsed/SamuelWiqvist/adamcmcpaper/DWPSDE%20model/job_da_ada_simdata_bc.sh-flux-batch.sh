#!/bin/bash
#FLUX: --job-name=da_ada_simdata_bc
#FLUX: -n=5
#FLUX: --queue=lu
#FLUX: -t=360000
#FLUX: --urgency=16

ml load icc/2017.1.132-GCC-6.3.0-2.27
ml load impi/2017.1.132
ml load julia/0.5.2
julia run_da_ada_same_training_data.jl simdata biasedcoin
