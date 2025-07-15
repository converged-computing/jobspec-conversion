#!/bin/bash
#FLUX: --job-name=cowy-platanos-5821
#FLUX: --priority=16

set -x
cd $SLURM_SUBMIT_DIR
[ -f ld_env.sh ] && . ./ld_env.sh # To load an environment file if necessary
srun -n $SLURM_NTASKS ./mise_a_jour_TRUST_arch 1>~/CR_callisto-intel 2>&1 
