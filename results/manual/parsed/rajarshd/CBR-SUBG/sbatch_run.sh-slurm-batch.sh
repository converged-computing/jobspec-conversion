#!/bin/bash
#SBATCH --job-name=FreebaseQA
#SBATCH --output=/home/rajarshi/Dropbox/research/cbr-weak-supervision/wandb/wandb-%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=60G
#SBATCH --time=4-00:00:00
#SBATCH --array=0-5

wandb agent rajarshd/cbr-weak-supervision/zdydurcs
