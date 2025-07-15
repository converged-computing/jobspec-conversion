#!/bin/bash
#FLUX: --job-name=crunchy-chip-6955
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --priority=16

python /home/mmylee/term-project/train-talcresnet50.py
conda deactivate
