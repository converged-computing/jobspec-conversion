#!/bin/bash
#FLUX: --job-name=salted-despacito-9828
#FLUX: -t=432000
#FLUX: --priority=16

module load matlab
srun matlab_multithread -nodisplay -nosplash -r "WCnet_mixeddelays_noisy_posteriorpredictivechecks($SLURM_ARRAY_TASK_ID) ; exit(0)"
