#!/bin/bash
#FLUX: --job-name=passt
#FLUX: --queue=compute
#FLUX: -t=43200
#FLUX: --urgency=16

pwd; hostname;
TIME=$(date -Iseconds)
echo $TIME
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/anaconda3/envs/ba3l/lib DDP=2 CUDA_VISIBLE_DEVICES=0,1 python ex_nsynth.py with models.net.rf_norm_t=high_low_branch trainer.use_tensorboard_logger=True -p --debug
