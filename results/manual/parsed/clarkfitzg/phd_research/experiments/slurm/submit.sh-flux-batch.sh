#!/bin/bash
#FLUX: --job-name=find_word
#FLUX: --priority=16

module load R
srun bash stream_find_word.sh
