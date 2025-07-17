#!/bin/bash
#FLUX: --job-name=mise_a_jour_TRUST_arch
#FLUX: --queue=slim,large,fat,eris,pluton
#FLUX: -t=43200
#FLUX: --urgency=16

set -x
cd $SLURM_SUBMIT_DIR
[ -f ld_env.sh ] && . ./ld_env.sh # To load an environment file if necessary
srun -n $SLURM_NTASKS ./mise_a_jour_TRUST_arch 1>~/CR_callisto-intel 2>&1 
