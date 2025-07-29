#!/bin/bash
#SBATCH --job-name=paraview
#SBATCH --output=%x-%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --cpus-per-task=1
#SBATCH --time=2-20:00:00
#SBATCH --partition=debug

export PROG='pvserver --force-offscreen-rendering'

echo "Working Directory = $(pwd)"
cd $SLURM_SUBMIT_DIR
export PROG="pvserver --force-offscreen-rendering"
module load paraview 
srun $PROG
