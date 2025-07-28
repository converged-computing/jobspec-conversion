#!/bin/bash
#FLUX: --job-name=astute-pedo-5368
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

python /home/mmylee/term-project/train-talcresnet50.py
conda deactivate
