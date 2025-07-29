#!/bin/bash
#SBATCH --job-name=fooocus-demo
#SBATCH --output=./logs/%x-%j.log
#SBATCH --error=./logs/%x-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:rtx:1
#SBATCH --partition=pot
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --nodelist=ccnl07

export TMPDIR='./temp'

export TMPDIR=./temp
python entry_with_update.py --listen --preset taiyi
