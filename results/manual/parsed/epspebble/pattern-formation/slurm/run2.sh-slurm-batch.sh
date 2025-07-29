#!/bin/bash
#FLUX: --job-name=bumfuzzled-leg-8849
#FLUX: -c=4
#FLUX: -t=20
#FLUX: --urgency=16

module load matlab
cd ~/project/pattern-formation/zebrafish
matlab -batch "run2($SLURM_ARRAY_TASK_ID)"
