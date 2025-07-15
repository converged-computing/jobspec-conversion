#!/bin/bash
#FLUX: --job-name=adorable-buttface-8214
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

python /home/mmylee/term-project/train-talcresnet50.py
conda deactivate
