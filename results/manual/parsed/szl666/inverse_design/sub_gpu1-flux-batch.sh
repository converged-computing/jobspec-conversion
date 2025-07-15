#!/bin/bash
#FLUX: --job-name=conspicuous-carrot-9572
#FLUX: -c=20
#FLUX: --urgency=16

module load cuda/11.3
python stable_pre.py
