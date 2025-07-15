#!/bin/bash
#FLUX: --job-name="paraview"
#FLUX: --priority=16

export PROG='pvserver --force-offscreen-rendering'

echo "Working Directory = $(pwd)"
cd $SLURM_SUBMIT_DIR
export PROG="pvserver --force-offscreen-rendering"
module load paraview 
srun $PROG
