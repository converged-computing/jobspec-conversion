#!/bin/bash
#SBATCH --job-name=CUTEst_one_phase
#SBATCH --output=../results/screen/log.%j.out
#SBATCH --error=../results/errors/log.%j.err
#SBATCH --mail-user=ohinder@stanford.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --partition=jduchi
#SBATCH --qos=normal

ml load CUTEst/linux-cutest
ml load julia/precompiled/0.5.0
ml load hdf5
julia run_one_phase.jl
