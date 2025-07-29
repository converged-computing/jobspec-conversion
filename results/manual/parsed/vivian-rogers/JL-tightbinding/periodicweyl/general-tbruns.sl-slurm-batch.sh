#!/bin/bash
#SBATCH --job-name=JL.p.weyl
#SBATCH --account=OTH21017
#SBATCH --output=../outputs/jl-tb.o%j
#SBATCH --mail-user=8326909459@tmomail.net
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=128
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=normal

export LD_LIBRARY_PATH=' '
export LD_PRELOAD=''
export JULIA_NUM_THREADS='ntot'
export DISPLAY=':1'

n=128 # number of tasks per node
N=1 # number of tasks
ntot=$((n * N))
export LD_LIBRARY_PATH="" 
export LD_PRELOAD=""
export JULIA_NUM_THREADS=ntot
vncserver
export DISPLAY=:1
julia runs.jl
