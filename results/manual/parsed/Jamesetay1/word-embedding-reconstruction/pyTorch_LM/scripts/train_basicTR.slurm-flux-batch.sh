#!/bin/bash
#FLUX: --job-name=TRLM_little
#FLUX: --queue=gpu
#FLUX: -t=345600
#FLUX: --priority=16

pwd; hostname; date
source /work/tc046/tc046/jamesetay1/subword-to-word/venv/bin/activate
python main.py \
--cuda \
--epochs 50 \
--model Transformer \
--data ./data/wikitext-103 \
--batch_size 64
date
