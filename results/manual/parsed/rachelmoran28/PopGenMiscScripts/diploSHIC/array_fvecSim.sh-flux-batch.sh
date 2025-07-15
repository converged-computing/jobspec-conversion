#!/bin/bash
#FLUX: --job-name=persnickety-pot-3146
#FLUX: --priority=16

cd /home/mcgaughs/shared/Software/diploSHIC
CMD_LIST="Surface.fvecSim.commnads.txt"                                                                                                                                                               
CMD="$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${CMD_LIST})"
eval ${CMD}
