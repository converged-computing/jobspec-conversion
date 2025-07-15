#!/bin/bash
#FLUX: --job-name=gloopy-fork-7570
#FLUX: -c=20
#FLUX: --priority=16

module load cuda/11.3
python stable_pre.py
