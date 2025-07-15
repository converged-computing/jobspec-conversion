#!/bin/bash
#FLUX: --job-name=strawberry-staircase-6626
#FLUX: -N=8
#FLUX: -n=8
#FLUX: -c=12
#FLUX: --queue=normal
#FLUX: -t=300
#FLUX: --urgency=16

export MASTER_ADDR='$(hostname)'
export NSYS_NODE_INTERVAL='$((ngpus/stages))'
export NSYS_OUTPUT='bert_prof/${model}_${pipeline}_${stages}stages_${ngpus}gpus_microbs${microbs}_acc${acc}'

module load daint-gpu
conda activate py38_kfac
export MASTER_ADDR=$(hostname)
model=bert-large
pipeline='interleave'
stages=8
ngpus=8
microbs=32
acc=1
export NSYS_NODE_INTERVAL=$((ngpus/stages))
export NSYS_OUTPUT=bert_prof/${model}_${pipeline}_${stages}stages_${ngpus}gpus_microbs${microbs}_acc${acc}
srun --wait=0 scripts/nsys_wrap.sh \
    python main_bert.py \
            --num_stages $stages \
            --corpus_path ./bert_data/wikipedia.segmented.nltk.txt \
            --vocab_path ./bert_data/bert-large-uncased-vocab.txt \
            --corpus_lines 10000 \
            --do_lower_case \
            --bert_config_path ./configs/bert_config_${model}-uncased.json \
            --max_seq_length 128 \
            --micro_batch_size $microbs \
            --num_optimization_steps 8 \
            --gradient_accumulation_steps $acc \
            --pipeline_method $pipeline \
            --p2p_backend 'gloo' \
            --collective_backend 'nccl' \
            --profile \
	    --chunks 2 \
