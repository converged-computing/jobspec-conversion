#!/bin/bash
#FLUX --job-name=tart-diablo-9484
#FLUX -c=2
#FLUX --queue=gpu
#FLUX -t=86400
#FLUX --urgency=16

python /home/mmylee/term-project/train-talcresnet50.py
conda deactivate
