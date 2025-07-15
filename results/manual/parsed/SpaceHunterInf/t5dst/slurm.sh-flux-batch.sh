#!/bin/bash
#FLUX: --job-name=scruptious-buttface-0646
#FLUX: -c=2
#FLUX: -t=3596400
#FLUX: --urgency=16

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
