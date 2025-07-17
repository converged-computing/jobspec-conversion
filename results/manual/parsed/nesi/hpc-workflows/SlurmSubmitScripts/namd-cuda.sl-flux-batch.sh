#!/bin/bash
#FLUX: --job-name=GROMACS_JOB
#FLUX: -c=2
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

source /etc/profile
module load NAMD/2.9
cp -pr /share/test/NAMD/apoa1/* $SCRATCH_DIR
cd $SCRATCH_DIR
export OMP_NUM_THREADS=1
srun namd2 apoa1.namd
cp -pr $SCRATCH_DIR $HOME/OUT/namd
