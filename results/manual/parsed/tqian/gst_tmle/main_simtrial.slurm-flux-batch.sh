#!/bin/bash
#FLUX: --job-name=crunchy-leopard-4698
#FLUX: --urgency=16

export R_LIBS_USER='$HOME/apps/R_3.6.1:$R_LIBS_USER'

module load gcc/8.2.0-fasrc01 openmpi/3.1.1-fasrc01 R/3.6.1-fasrc01 # load R
export R_LIBS_USER=$HOME/apps/R_3.6.1:$R_LIBS_USER
R CMD BATCH /n/home00/tqian/gst_tmle/main_simtrial.R /n/home00/tqian/gst_tmle/Rout/main_simtrial.Rout.${SLURM_ARRAY_TASK_ID}
