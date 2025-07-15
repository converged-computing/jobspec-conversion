#!/bin/bash
#FLUX: --job-name=post_processing
#FLUX: --urgency=16

module load python/3.10.12
module load cuda
module load nccl
pipenv run python functions/post_processing.py
