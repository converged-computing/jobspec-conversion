#!/bin/bash
#FLUX: --job-name=grated-hippo-4952
#FLUX: -c=4
#FLUX: -t=20
#FLUX: --priority=16

module load matlab
cd ~/project/pattern-formation/zebrafish
matlab -batch "run2($SLURM_ARRAY_TASK_ID)"
