#!/bin/bash
#FLUX: --job-name=anxious-kitty-3536
#FLUX: -t=600
#FLUX: --urgency=16

echo $SLURM_JOB_NODELIST
module load cuda/10.1.105
nvprof -o prof_v2 ./main
echo "done"
