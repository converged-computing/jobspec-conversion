#!/bin/bash
#FLUX: --job-name=crunchy-pancake-1415
#FLUX: --urgency=16

set echo
set -x
module load namd/2.13-gpu
BASENAME=prod_ds1
cd $SLURM_SUBMIT_DIR
echo $SLURM_NTASKS
$BINDIR/namd2 +setcpuaffinity +p 40 +devices 0,1,2,3,4,5,6,7 ${BASENAME}.namd > ${BASENAME}.log
