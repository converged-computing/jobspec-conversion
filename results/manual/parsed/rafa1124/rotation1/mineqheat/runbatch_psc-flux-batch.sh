#!/bin/bash
#FLUX: --job-name=spicy-fork-1439
#FLUX: -N=16
#FLUX: -c=14
#FLUX: --queue=RM
#FLUX: -t=14400
#FLUX: --urgency=16

set echo
set -x
module load namd
cd $SLURM_SUBMIT_DIR
mpirun -np $SLURM_NTASKS namd2 +ppn 12 +pemap 1-6,15-20,8-13,22-27 +commap 0,14,7,21 11heat.conf >& 11heat.log
