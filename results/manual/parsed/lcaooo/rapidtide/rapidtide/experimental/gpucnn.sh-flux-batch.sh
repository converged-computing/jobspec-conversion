#!/bin/bash
#FLUX: --job-name=swampy-house-4705
#FLUX: --urgency=16

module load cuda91
python main.py
