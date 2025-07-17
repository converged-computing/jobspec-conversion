#!/bin/bash
#FLUX: --job-name=fvecSim
#FLUX: --queue=small,amdsmall,astyanax
#FLUX: -t=10800
#FLUX: --urgency=16

cd /home/mcgaughs/shared/Software/diploSHIC
CMD_LIST="Surface.fvecSim.commnads.txt"                                                                                                                                                               
CMD="$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${CMD_LIST})"
eval ${CMD}
