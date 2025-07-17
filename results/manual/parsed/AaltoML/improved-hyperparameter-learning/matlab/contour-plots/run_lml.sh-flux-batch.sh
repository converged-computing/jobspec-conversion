#!/bin/bash
#FLUX: --job-name=reclusive-hippo-6927
#FLUX: -c=3
#FLUX: --queue=batch
#FLUX: -t=360000
#FLUX: --urgency=16

mkdir -p lml/ionosphere
srun matlab -nojvm -nosplash -batch "MCMC_lml($SLURM_ARRAY_TASK_ID, 'ionosphere', -1, 5)"
