#!/bin/bash
#FLUX: --job-name=scruptious-platanos-0623
#FLUX: -t=600
#FLUX: --priority=16

echo $SLURM_JOB_NODELIST
module load cuda/10.1.105
nvprof -o prof_v2 ./main
echo "done"
