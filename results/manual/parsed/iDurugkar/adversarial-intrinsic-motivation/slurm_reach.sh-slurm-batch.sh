#!/bin/bash
#FLUX: --job-name=gail_reach
#FLUX: -c=8
#FLUX: --queue=titans
#FLUX: -t=3600
#FLUX: --urgency=16

SEED=$(($SLURM_ARRAY_TASK_ID + 1010))
SEED2=$(($SEED + 3))
FILE=r_gail_td3
sleep $SLURM_ARRAY_TASK_ID * 3
python -u train.py --algo her --env FetchReach-v1 --tensorboard-log /scratch/cluster/ishand/results/zoo2/$FILE --eval-episodes 100 --eval-freq 2000 -f /scratch/cluster/ishand/results/zoo2/$FILE --seed $SEED &
sleep $SLURM_ARRAY_TASK_ID * 7
python -u train.py --algo her --env FetchReach-v1 --tensorboard-log /scratch/cluster/ishand/results/zoo2/$FILE --eval-episodes 100 --eval-freq 2000 -f /scratch/cluster/ishand/results/zoo2/$FILE --seed $SEED2 &
wait
