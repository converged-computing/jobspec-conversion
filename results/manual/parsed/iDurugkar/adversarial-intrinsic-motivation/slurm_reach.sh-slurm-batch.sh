#!/bin/bash
#SBATCH --job-name=gail_reach
#SBATCH --output=/scratch/cluster/ishand/results/zoo2/gail_reach_%A_%a.out
#SBATCH --error=/scratch/cluster/ishand/results/zoo2/gail_reach_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=12G
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=1

SEED=$(($SLURM_ARRAY_TASK_ID + 1010))
SEED2=$(($SEED + 3))
FILE=r_gail_td3
sleep $SLURM_ARRAY_TASK_ID * 3
python -u train.py --algo her --env FetchReach-v1 --tensorboard-log /scratch/cluster/ishand/results/zoo2/$FILE --eval-episodes 100 --eval-freq 2000 -f /scratch/cluster/ishand/results/zoo2/$FILE --seed $SEED &
sleep $SLURM_ARRAY_TASK_ID * 7
python -u train.py --algo her --env FetchReach-v1 --tensorboard-log /scratch/cluster/ishand/results/zoo2/$FILE --eval-episodes 100 --eval-freq 2000 -f /scratch/cluster/ishand/results/zoo2/$FILE --seed $SEED2 &
wait
