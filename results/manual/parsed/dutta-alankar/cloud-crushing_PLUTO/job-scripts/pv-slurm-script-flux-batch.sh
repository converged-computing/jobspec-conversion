#!/bin/bash
#FLUX: --job-name=paraview
#FLUX: -n=48
#FLUX: --queue=debug
#FLUX: -t=244800
#FLUX: --urgency=16

export PROG='pvserver --force-offscreen-rendering'

echo "Working Directory = $(pwd)"
cd $SLURM_SUBMIT_DIR
export PROG="pvserver --force-offscreen-rendering"
module load paraview 
srun $PROG
