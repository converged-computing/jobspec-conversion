#!/bin/bash
#FLUX: --job-name=imagenet
#FLUX: -c=10
#FLUX: -t=72000
#FLUX: --urgency=16

module purge
module load cpuarch/amd
module load python
conda activate emergent_communication
set -x
num_senders=1
num_receivers=1
vocab_size=20
vocab_size_feedback=20
max_len=5
patience=100
training_time="00:20:00:00"
job_time="22:00:00"
entropy_coeff=0.01
seed=3
baseline_args="--batch-size 100 --precision=16 --accelerator=gpu --devices=1 --sender-entropy-coeff=$entropy_coeff --receiver-entropy-coeff=$entropy_coeff --seed=$seed --num-senders=$num_senders --num-receivers=$num_receivers --patience=$patience --vocab-size=$vocab_size --max-len=$max_len --val_check_interval 400 --limit_val_batches 100 --num-workers 10 --max_time=$training_time --sender-layer-norm --receiver-layer-norm --imagenet --discrimination-num-objects 2 --sender-embed-dim 10 --receiver-embed-dim 10 --hard-distractors"
fb_args="$baseline_args --feedback --vocab-size-feedback=$vocab_size_feedback"
python -u train.py $fb_args
