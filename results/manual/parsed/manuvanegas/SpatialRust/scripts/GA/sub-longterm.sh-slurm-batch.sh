#!/bin/bash
#FLUX: --job-name=fittest
#FLUX: --queue=htc
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load julia/1.9.0
echo `date +%F-%T`
ulimit -s 262144
julia ~/SpatialRust/scripts/GA/runFittest.jl /home/mvanega1/SpatialRust/results/GA4/fittest/parsdfNF.csv $SLURM_ARRAY_TASK_ID 100
echo `date +%F-%T`
exit 0
