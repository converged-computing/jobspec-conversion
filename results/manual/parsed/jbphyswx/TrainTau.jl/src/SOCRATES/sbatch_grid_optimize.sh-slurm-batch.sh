#!/bin/bash
#SBATCH --job-name=SBATCH_SCORATES_GRID_optimize
#SBATCH --output=/home/jbenjami/Research_Schneider/CliMa/TrainTau.jl/sbatch_grid_optimize.out
#SBATCH --mail-user=jbenjami@caltech.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:0
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=1

module load julia/1.9.3
julia --project=/home/jbenjami/Research_Schneider/CliMa/TrainTau.jl/ -e 'include("/home/jbenjami/Research_Schneider/CliMa/TrainTau.jl/src/TrainTau.jl");  TrainTau.grid_search_optimize();'
