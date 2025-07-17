#!/bin/bash
#FLUX: --job-name=medical
#FLUX: -c=4
#FLUX: -t=601200
#FLUX: --urgency=16

pyenv activate moose_env
module load cuda
CUDA_VISIBLE_DEVICES=0 python /misc/no_backups/s1449/Medical-Images-Synthesis/utils/miou_folder/moose_segment.py
