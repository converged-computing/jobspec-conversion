#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=2

export PYTHON='${HOME}/sklearn-env/bin/python'

MAX_SEED=$1
DATASET=$2
HP_SAMPLING=$3
CONTAMINATION=$4
module load Julia/1.5.1-linux-x86_64
module load Python/3.8.2-GCCcore-9.3.0
source ${HOME}/sklearn-env/bin/activate
export PYTHON="${HOME}/sklearn-env/bin/python"
julia --project -e 'using Pkg; Pkg.build("PyCall"); @info("SETUP DONE")'
julia ./hbos.jl ${MAX_SEED} $DATASET ${HP_SAMPLING} $CONTAMINATION
