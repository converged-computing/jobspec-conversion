#!/bin/bash
#FLUX: --job-name=phat-soup-4227
#FLUX: --queue=gpu
#FLUX: -t=57600
#FLUX: --urgency=16

module load cuda91
python main.py
