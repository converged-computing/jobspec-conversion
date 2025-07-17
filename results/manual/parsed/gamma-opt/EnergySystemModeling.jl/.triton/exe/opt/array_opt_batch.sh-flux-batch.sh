#!/bin/bash
#FLUX: --job-name=dirty-platanos-8873
#FLUX: -t=172800
#FLUX: --urgency=16

n=$SLURM_ARRAY_TASK_ID
instance=`sed -n "${n} p" instances1.txt`      # Get n-th line (1-indexed) of the file
srun julia /scratch/work/condeil1/EnergySystemModeling.jl/.triton/exe/opt/run_clust.jl ${instance}
srun julia /scratch/work/condeil1/EnergySystemModeling.jl/.triton/exe/opt/run_fix.jl ${instance}
