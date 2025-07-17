#!/bin/bash
#FLUX: --job-name=pmicogs
#FLUX: -c=5
#FLUX: -t=172800
#FLUX: --urgency=50

lr=1.0
warmup_steps=4000
max_steps=8000
expname=pmi
mkdir -p $expname
cd $expname
home="../../../"
for i in `seq 0 9`
do
if [[ $i -eq $SLURM_ARRAY_TASK_ID ]]; then
    python -u  $home/main.py \
    --seed $i \
    --n_batch 128 \
    --n_layers 2 \
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
    --copy \
    --tb_dir ${expname} \
    --aligner $home/COGS/cogs/alignments/pmi.align.json \
    --tolarance 10 \
    --COGS > eval.$i.out 2> eval.$i.err
fi
done
