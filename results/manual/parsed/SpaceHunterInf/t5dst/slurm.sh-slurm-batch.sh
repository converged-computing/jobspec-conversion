#!/bin/bash
#SBATCH --job-name=557flant5dst
#SBATCH --output=./log/slurm-out-%j.txt
#SBATCH --error=./log/slurm-err-%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:rtx_6000_ada:2
#SBATCH --time=41-15:00:00
#SBATCH --array=0-2

eval "$(conda shell.bash hook)"
N="$SLURM_ARRAY_TASK_ID"
conda activate adapter
TASKS=(english arabic french)
lang=${TASKS[N]}
saving_dir=output/$lang/flan-t5/small-357/5epochs/
python T5.py \
  --model_checkpoint 'google/flan-t5-small' \
  --model_name 'flan-t5' \
  --train_batch_size 4 \
  --GPU 2 \
  --seed 557\
  --slot_lang slottype \
  --n_epochs 5 \
  --saving_dir $saving_dir \
  --data_dir data/new_dst_$lang
