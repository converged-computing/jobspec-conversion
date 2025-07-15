#!/bin/bash
#FLUX: --job-name=fit
#FLUX: --queue=cpu-2h
#FLUX: --priority=16

if [ $1 == "train" ]; then
    apptainer run --nv gomoku.sif python -m src.train ${@:2}
elif [ $1 == "eval" ]; then
    apptainer run --nv gomoku.sif python -m src.comp ${@:2}
elif [ $1 == "stats" ]; then
    apptainer run --nv gomoku.sif python -m src.stats ${@:2}	
else
    echo "Usage: sbatch fit.sh <train|eval|stats> …"
    exit 1
fi
