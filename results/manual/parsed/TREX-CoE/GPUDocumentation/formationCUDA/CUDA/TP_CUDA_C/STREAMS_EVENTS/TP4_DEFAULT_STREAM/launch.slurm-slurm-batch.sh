#!/bin/bash
#FLUX: --job-name=cuda_4_calmip_test
#FLUX: -n=16
#FLUX: -t=600
#FLUX: --urgency=16

echo $SLURM_JOB_NODELIST
module load cuda/10.1.105
nvprof -o prof_v2 ./main
echo "done"
