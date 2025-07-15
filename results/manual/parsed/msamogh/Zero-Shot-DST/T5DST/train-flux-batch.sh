#!/bin/bash
#FLUX: --job-name=placid-bike-7716
#FLUX: --queue=gpu
#FLUX: --urgency=16

echo wassup
nvidia-smi
module load cuda/11.4.3
~/myblue/woz/cai-nlp/venv/bin/python T5.py --train_batch_size 2 --GPU 1 --except_domain taxi --slot_lang slottype
