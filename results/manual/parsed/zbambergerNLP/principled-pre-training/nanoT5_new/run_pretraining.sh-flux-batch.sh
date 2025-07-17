#!/bin/bash
#FLUX: --job-name=pre_training_job
#FLUX: -c=80
#FLUX: --queue=nlp
#FLUX: --urgency=16

export GPUS_PER_NODE='6'

nvidia-smi
export GPUS_PER_NODE=6
accelerate launch -m \
--mixed_precision bf16 \
--num_cpu_threads_per_process 64 \
--num_processes 6 \
nanoT5.main \
optim.name=adamwscale \
optim.lr_scheduler=cosine \
model.compile=true \
num_gpus=6 \
num_cpus=64 \
data.num_workers=64
