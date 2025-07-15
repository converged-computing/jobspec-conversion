#!/bin/bash
#FLUX: --job-name=evasive-banana-4946
#FLUX: -n=3
#FLUX: --urgency=16

module load python/anaconda3
conda activate raft
python3 core/Tests.py
