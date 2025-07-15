#!/bin/bash
#FLUX: --job-name=arid-pastry-6493
#FLUX: --urgency=16

cd /home/mcgaughs/shared/Software/diploSHIC
discoal="/home/mcgaughs/shared/Software/discoal/discoal"
CMD_LIST="Surface_discoal_commands_w_3popsizes_2.txt"
CMD="$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${CMD_LIST})"
eval ${CMD}
