#!/bin/bash
#SBATCH --job-name=tax2D
#SBATCH --output=../results/screen/log.%j.out
#SBATCH --error=../results/errors/log.%j.err
#SBATCH --mail-user=ohinder@stanford.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8000
#SBATCH --time=2-00:00:00
#SBATCH --partition=hns,normal
#SBATCH --qos=normal

ml load CUTEst/linux-cutest
ml load julia/precompiled/0.5.0
ml load hdf5
cd ~/one-phase-2.0/Examples
julia tax2D.jl
