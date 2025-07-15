#!/bin/bash
#FLUX: --job-name=red-fudge-5231
#FLUX: --urgency=16

module load 2019 Anaconda3
source activate my_root
cp -r "$HOME"/ARVARSim "$TMPDIR"
cd "$TMPDIR"/ARVARSim
echo $SLURM_ARRAY_TASK_ID
Rscript --vanilla Sim_LISA.R $SLURM_ARRAY_TASK_ID
cp -r ./*.RDS "$HOME"/ARVARSim/output
