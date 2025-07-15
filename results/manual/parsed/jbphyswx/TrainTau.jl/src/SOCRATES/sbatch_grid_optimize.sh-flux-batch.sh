#!/bin/bash
#FLUX: --job-name=SBATCH_SCORATES_GRID_optimize
#FLUX: -t=172800
#FLUX: --priority=16

module load julia/1.9.3
julia --project=/home/jbenjami/Research_Schneider/CliMa/TrainTau.jl/ -e 'include("/home/jbenjami/Research_Schneider/CliMa/TrainTau.jl/src/TrainTau.jl");  TrainTau.grid_search_optimize();'
