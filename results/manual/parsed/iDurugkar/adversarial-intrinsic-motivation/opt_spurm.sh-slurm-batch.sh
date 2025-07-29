#!/bin/bash
#SBATCH --job-name=opt_push
#SBATCH --output=/scratch/cluster/ishand/results/zoo2/push_opt_%A_%a.out
#SBATCH --error=/scratch/cluster/ishand/results/zoo2/push_opt_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=10G
#SBATCH --time=7-00:00:00
#SBATCH --partition=titans
#SBATCH --constraint=ntasks-per-node=1

sleep $(($SLURM_ARRAY_TASK_ID))
python -u train.py --algo her --env FetchPush-v1 -n 500000 -optimize --n-trials 50 --n-jobs 2 --sampler tpe --pruner median --tensorboard-log /scratch/cluster/ishand/results/zoo2/aimher_rew_04/Push -f /scratch/cluster/ishand/results/zoo2/aimher_rew_04/Push &
wait
