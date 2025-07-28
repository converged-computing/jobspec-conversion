#!/bin/bash
#FLUX: --job-name=GENRAY
#FLUX: -N=2
#FLUX: --queue=regular
#FLUX: -t=120
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/global/homes/y/ypetrov/pgplot.intel'

cd $SLURM_SUBMIT_DIR
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/global/homes/y/ypetrov/pgplot.intel
srun -n 32 -c 4 --cpu_bind=cores ./xgenray_mpi_intel.cori
