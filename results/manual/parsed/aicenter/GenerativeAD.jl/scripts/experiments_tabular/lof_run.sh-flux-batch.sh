#!/bin/bash
#FLUX: --job-name=anxious-cattywampus-7564
#FLUX: -t=86400
#FLUX: --urgency=16

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
julia ./lof.jl ${MAX_SEED} $DATASET ${HP_SAMPLING} $CONTAMINATION
