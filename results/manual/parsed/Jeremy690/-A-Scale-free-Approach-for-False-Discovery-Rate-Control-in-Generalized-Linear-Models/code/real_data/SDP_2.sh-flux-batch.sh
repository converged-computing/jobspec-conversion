#!/bin/bash
#FLUX: --job-name=fuzzy-train-9974
#FLUX: --priority=16

export R_LIBS_USER='$HOME/apps/R:$R_LIBS_USER'

module load gcc/7.1.0-fasrc01 R/3.6.3-fasrc01
export R_LIBS_USER=$HOME/apps/R:$R_LIBS_USER
input=Simul_SDP2.R
cd /n/home09/cdai/FDR/real_data/code
R CMD BATCH $input out/$input.$SLURM_ARRAY_TASK_ID.out
sleep 1                                          # pause to be kind to the scheduler
done
