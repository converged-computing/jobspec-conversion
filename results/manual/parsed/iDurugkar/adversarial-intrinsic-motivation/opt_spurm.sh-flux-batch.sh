#!/bin/bash
#FLUX: --job-name=opt_push
#FLUX: -c=8
#FLUX: --queue=titans
#FLUX: -t=604800
#FLUX: --urgency=16

sleep $(($SLURM_ARRAY_TASK_ID))
python -u train.py --algo her --env FetchPush-v1 -n 500000 -optimize --n-trials 50 --n-jobs 2 --sampler tpe --pruner median --tensorboard-log /scratch/cluster/ishand/results/zoo2/aimher_rew_04/Push -f /scratch/cluster/ishand/results/zoo2/aimher_rew_04/Push &
wait
