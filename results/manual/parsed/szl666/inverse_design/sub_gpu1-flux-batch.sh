#!/bin/bash
#FLUX: --job-name=zhilong
#FLUX: -c=20
#FLUX: --queue=gpu4
#FLUX: --urgency=16

module load cuda/11.3
python stable_pre.py
