#!/bin/bash
#FLUX: --job-name=bubble3D
#FLUX: -N=2
#FLUX: -n=20
#FLUX: -t=72000
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
module load gcc/7.3.0
module load python/3.6.5
module load openmpi/3.1.1
mpirun ./bucket3D bucket3D.xml
