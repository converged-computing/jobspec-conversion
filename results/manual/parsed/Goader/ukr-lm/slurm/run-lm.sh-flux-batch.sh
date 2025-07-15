#!/bin/bash
#FLUX: --job-name=ukrlm_mlm
#FLUX: -c=16
#FLUX: --queue=plgrid-gpu-a100
#FLUX: -t=172800
#FLUX: --urgency=16

source modules.sh
source scratch/masters/masters-venv/bin/activate
cd masters/ukr-lm
python3 main-ml.py \
    accelerator=gpu \
    datamodule.batch_size=64 \
    huggingface_cache_dir=/net/people/plgrid/plggoader/scratch/masters/huggingface_cache/ \
    datasets.cc100.streaming=true \
    task.strategy=ddp \
    datasets.cc100.num_shards=1 \
    datamodule.num_workers=1 \
    devices=-1
