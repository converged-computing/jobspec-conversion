#!/bin/bash
#FLUX: --job-name=slurm_exp_3
#FLUX: --exclusive
#FLUX: --queue=general
#FLUX: -t=43200
#FLUX: --urgency=16

export SLURM_ARRAY_TASK_ID
module load gcc/11.3.0
module load r/4.2.1
module load gdal/3.6.1 gsl
source /gpfs/sharedfs1/admin/hpc2.0/apps/gdal/3.6.1/spack/share/spack/setup-env.sh
spack load gdal
echo $SLURM_ARRAY_TASK_ID": Running SLURM task"
Rscript $HOME/dissertation/exp_3/2-parallel_radius_search-nested.R
echo $SLURM_ARRAY_TASK_ID ": Job done"
