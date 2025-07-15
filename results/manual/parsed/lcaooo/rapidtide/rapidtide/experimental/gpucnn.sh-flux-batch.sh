#!/bin/bash
#FLUX: --job-name=arid-staircase-4764
#FLUX: --priority=16

module load cuda91
python main.py
