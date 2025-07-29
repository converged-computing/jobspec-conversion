#!/bin/bash
#SBATCH --job-name=rnd
#SBATCH --output=/scratch/cluster/ishand/results/zoo2/rnd_td3_%A_%a.out
#SBATCH --error=/scratch/cluster/ishand/results/zoo2/rnd_td3_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=12G
#SBATCH --time=4-00:00:00
#SBATCH --constraint=ntasks-per-node=1

SEED=$(($SLURM_ARRAY_TASK_ID + 1010))
SEED2=$(($SLURM_ARRAY_TASK_ID + 3 + 1010))
FILE=rnd_td3_10
sleep $SLURM_ARRAY_TASK_ID
python -u train.py --algo her --env FetchPush-v1 --tensorboard-log /scratch/cluster/ishand/results/zoo2/$FILE --eval-episodes 100 --eval-freq 20000 -f /scratch/cluster/ishand/results/zoo2/$FILE --seed $SEED --verbose 0 &
sleep 15
python -u train.py --algo her --env FetchPush-v1 --tensorboard-log /scratch/cluster/ishand/results/zoo2/$FILE --eval-episodes 100 --eval-freq 20000 -f /scratch/cluster/ishand/results/zoo2/$FILE --seed $SEED2 --verbose 0 &
wait
