#!/bin/bash
#FLUX: --job-name=gloopy-hope-3104
#FLUX: --queue=gpu
#FLUX: --priority=16

echo wassup
nvidia-smi
module load cuda/11.4.3
~/myblue/woz/cai-nlp/venv/bin/python T5.py --train_batch_size 2 --GPU 1 --except_domain taxi --slot_lang slottype
