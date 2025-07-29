#!/bin/bash
#SBATCH --job-name=SLU
#SBATCH --output=log/slu_%A_%a.out
#SBATCH --error=log/slu_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --partition=2080ti
#SBATCH --array=0-17

dataset=(atis snips)
ratio=(0.05 0.1 1.0)
model=(birnn birnn+crf focus)
cur_d=${dataset[SLURM_ARRAY_TASK_ID / 9]}
cur_r=${ratio[(SLURM_ARRAY_TASK_ID % 9) / 3]}
cur_m=${model[SLURM_ARRAY_TASK_ID % 3]}
source activate slu
./run/run_slu_bert.sh ${cur_d} ${cur_r} ${cur_m}
