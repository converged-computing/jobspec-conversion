#!/bin/bash
#FLUX: --job-name=Eval$1$2$3
#FLUX: -t=36000
#FLUX: --urgency=16

source /dcsrsoft/spack/bin/setup_dcsrsoft
module load gcc/9.3.0 r/4.0.5
module load geos/3.8.1 
module load netcdf-c/4.8.0
module load proj/5.2.0 
module load gdal/2.4.4-proj-5.2.0
Rscript code/02_Eval.R $SLURM_ARRAY_TASK_ID $1 $2 $3
