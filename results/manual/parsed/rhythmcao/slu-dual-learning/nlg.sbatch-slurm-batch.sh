#!/bin/bash
#SBATCH --job-name=NLG
#SBATCH --output=log/nlg_%A_%a.out
#SBATCH --error=log/nlg_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --array=0-11

dataset=(atis snips)
ratio=(0.05 0.1 1.0)
model=(sclstm sclstm+copy)
cur_d=${dataset[SLURM_ARRAY_TASK_ID / 6]}
cur_r=${ratio[(SLURM_ARRAY_TASK_ID % 6) / 2]}
cur_m=${model[SLURM_ARRAY_TASK_ID % 2]}
source activate slu
./run/run_nlg.sh ${cur_d} ${cur_r} ${cur_m}
