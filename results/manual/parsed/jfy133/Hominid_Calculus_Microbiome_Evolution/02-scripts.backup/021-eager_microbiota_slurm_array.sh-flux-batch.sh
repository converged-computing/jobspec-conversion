#!/bin/bash
#FLUX: --job-name=tart-poo-1882
#FLUX: --queue=medium						# partition (queue) to submit to
#FLUX: --priority=16

FILES=($(find -L 04-analysis/screening/EMN_Neanderthal_phylogeny_check/eager/output -name '*OFN*' -type d))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}
unset DISPLAY && eagercli ${FILENAME}
