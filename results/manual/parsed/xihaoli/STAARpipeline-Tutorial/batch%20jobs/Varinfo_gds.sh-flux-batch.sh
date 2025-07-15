#!/bin/bash
#FLUX: --job-name=placid-cherry-3574
#FLUX: -t=8640
#FLUX: --priority=16

export R_LIBS_USER='$HOME/R-3.6.1-MKL'

module purge
module load gcc/8.2.0-fasrc01 openmpi/3.1.1-fasrc01
module load intel-mkl/2017.2.174-fasrc01
module load R/3.6.1-fasrc01
export R_LIBS_USER=$HOME/R-3.6.1-MKL
echo $R_LIBS_USER
/n/home05/zilinli/R-3.6.1/bin/Rscript --slave --no-restore --no-save Varinfo_gds.R ${SLURM_ARRAY_TASK_ID} > out"${SLURM_ARRAY_TASK_ID}".Rout
