#!/bin/bash
#FLUX: --job-name=NAMD
#FLUX: -n=24
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

module load NAMD/2.9
cp -pr /sNow/test/NAMD/apoa1/* $SCRATCH_DIR
cd $SCRATCH_DIR
export OMP_NUM_THREADS=1
srun namd2 apoa1.namd
cp -pr $SCRATCH_DIR $HOME/OUT/namd
