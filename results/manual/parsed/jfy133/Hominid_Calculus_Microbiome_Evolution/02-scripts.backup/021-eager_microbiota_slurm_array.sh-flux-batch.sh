#!/bin/bash
#FLUX: --job-name=EAGER_SlurmArray
#FLUX: -n=4
#FLUX: --queue=medium
#FLUX: -t=2820
#FLUX: --urgency=16

FILES=($(find -L 04-analysis/screening/EMN_Neanderthal_phylogeny_check/eager/output -name '*OFN*' -type d))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}
unset DISPLAY && eagercli ${FILENAME}
