#!/bin/bash
#FLUX: --job-name=gpt_test
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load python/3.10
python rydberg_rnn.py
