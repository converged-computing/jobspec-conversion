#!/bin/bash
#FLUX: --job-name=evasive-hippo-7017
#FLUX: --priority=16

module load pytorch1.0-cuda9.0-python3.6
python main.py --cuda
