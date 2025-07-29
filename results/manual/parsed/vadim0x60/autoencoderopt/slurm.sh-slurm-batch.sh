#!/bin/bash
#SBATCH --job-name=autoencoderopt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=4-00:00:00
#SBATCH --partition=mcs.default.q

export TASK='$(ls datasets | sed -n $SLURM_ARRAY_TASK_ID'p')'

export TASK=$(ls datasets | sed -n $SLURM_ARRAY_TASK_ID'p')
python opt.py
