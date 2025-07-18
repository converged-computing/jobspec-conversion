#!/bin/bash
#FLUX: --job-name=pmicolor
#FLUX: -c=5
#FLUX: -t=172800
#FLUX: --urgency=50

dim=512
lr=1.0
val_steps=2
nbatch=5
warmup_steps=$((32 * 14 / nbatch))
max_steps=$((200 * 14 / nbatch))
expname=pmi
tolarance=$max_steps
mkdir -p $expname
cd $expname
home="../../../"
for i in `seq 0 15`; do
  if [[ $i -eq $SLURM_ARRAY_TASK_ID ]]; then
    PYTHONHASHSEED=0 python $home/main.py \
    --seed $i \
    --n_batch ${nbatch} \
    --n_layers 2 \
    --dim ${dim} \
    --lr ${lr} \
    --full_data \
    --dropout 0.4 \
    --accum_count 1 \
    --valid_steps ${val_steps} \
    --attention \
    --max_step ${max_steps} \
    --tolarance ${tolarance} \
    --warmup_steps ${warmup_steps} \
    --copy \
    --highdrop \
    --highdropvalue 0.5 \
    --gclip 0.5 \
    --aligner $home/COLOR/alignments/pmi.align.json \
    --noqxy \
    --nobidirectional > eval.$i.out 2> eval.$i.err
  fi
done
