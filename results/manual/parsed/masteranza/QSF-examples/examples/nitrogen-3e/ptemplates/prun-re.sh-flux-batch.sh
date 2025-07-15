#!/bin/bash
#FLUX: --job-name=frigid-lettuce-9767
#FLUX: -t=259200
#FLUX: --urgency=16

srun /bin/hostname
module load plgrid/tools/cmake plgrid/libs/fftw/3.3.9 plgrid/libs/mkl/2021.3.0 plgrid/tools/intel/2021.3.0
cd $SLURM_SUBMIT_DIR
prj=`basename "$PWD"`
mpiexec ./qsf-${prj}-re PARAMS -r
