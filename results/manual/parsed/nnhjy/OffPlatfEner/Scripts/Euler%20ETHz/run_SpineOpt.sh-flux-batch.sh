#!/bin/bash
#FLUX: --job-name=runSpineOpt
#FLUX: -t=172800
#FLUX: --urgency=16

module load gurobi gcc/11.4.0 julia/1.10.2
cd $SCRATCH/path/to/the/SpineOptProject
julia ./path/to/run_SpineOpt.jl
