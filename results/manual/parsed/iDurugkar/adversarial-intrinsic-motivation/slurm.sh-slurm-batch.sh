#!/bin/bash
#FLUX: --job-name=rnd
#FLUX: -c=8
#FLUX: --queue=titans
#FLUX: -t=345600
#FLUX: --urgency=16

SEED=$(($SLURM_ARRAY_TASK_ID + 1010))
SEED2=$(($SLURM_ARRAY_TASK_ID + 3 + 1010))
FILE=rnd_td3_10
sleep $SLURM_ARRAY_TASK_ID
python -u train.py --algo her --env FetchPush-v1 --tensorboard-log /scratch/cluster/ishand/results/zoo2/$FILE --eval-episodes 100 --eval-freq 20000 -f /scratch/cluster/ishand/results/zoo2/$FILE --seed $SEED --verbose 0 &
sleep 15
python -u train.py --algo her --env FetchPush-v1 --tensorboard-log /scratch/cluster/ishand/results/zoo2/$FILE --eval-episodes 100 --eval-freq 20000 -f /scratch/cluster/ishand/results/zoo2/$FILE --seed $SEED2 --verbose 0 &
wait
