#!/bin/bash
#SBATCH --job-name=forgot_name
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=shard:0
#SBATCH --mem=50G
#SBATCH --time=13-08:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --nodelist=nexus3

CUDA_VISIBLE_DEVICES=-1 python Run.py --training-preset 5 --name "not_a_name"
