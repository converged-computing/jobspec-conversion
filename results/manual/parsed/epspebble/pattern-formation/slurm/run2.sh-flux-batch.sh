#!/bin/bash
#FLUX: --job-name=rainbow-lemon-2970
#FLUX: -c=4
#FLUX: -t=20
#FLUX: --urgency=16

module load matlab
cd ~/project/pattern-formation/zebrafish
matlab -batch "run2($SLURM_ARRAY_TASK_ID)"
