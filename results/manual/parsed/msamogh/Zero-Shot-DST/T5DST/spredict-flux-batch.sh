#!/bin/bash
#FLUX: --job-name=moolicious-pot-2838
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=72000
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='3,4'

echo wassup
nvidia-smi
module load cuda/11.4.3
export CUDA_VISIBLE_DEVICES=3,4
~/myblue/woz/cai-nlp/venv/bin/python T5.py \
    --mode predict \
    --GPU 1 \
    --slot_lang slottype \
    --ckpt_path save/t5-41000 \
    --only_domain escai
