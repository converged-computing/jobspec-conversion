#!/bin/bash
#FLUX: --job-name=fasttranslate
#FLUX: -c=5
#FLUX: -t=172800
#FLUX: --urgency=50

align="intersect"
lr=1.0
warmup_steps=4000
max_steps=8000
expname=fast_${align}
mkdir -p $expname
cd $expname
home="../../../"
for i in `seq 0 4`
do
  if [[ $i -eq $SLURM_ARRAY_TASK_ID ]]; then
    python -u  $home/main.py \
    --seed $i \
    --n_batch 128 \
    --n_layers 2 \
    --noregularize \
    --dim 512 \
    --lr ${lr} \
    --temp 1.0 \
    --dropout 0.4 \
    --beam_size 5 \
    --gclip 5.0 \
    --accum_count 4 \
    --valid_steps 500 \
    --warmup_steps ${warmup_steps} \
    --max_step ${max_steps} \
    --tolarance 10 \
    --aligner $home/TRANSLATE/alignments/${align}.align.o.json \
    --copy \
    --TRANSLATE > eval.$i.out 2> eval.$i.err
  fi
done
