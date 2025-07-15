#!/bin/bash
#FLUX: --job-name="nanot5_pre_training_job"
#FLUX: --priority=16

nvidia-smi
cd nanoT5 || exit
python -m nanoT5.main \
    optim.name=adamwscale \
    optim.lr_scheduler=cosine
