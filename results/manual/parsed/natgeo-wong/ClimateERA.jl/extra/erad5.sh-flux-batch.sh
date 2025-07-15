#!/bin/bash
#FLUX: --job-name=arid-frito-1549
#FLUX: --priority=16

module load Anaconda3/5.0.1-fasrc02
source activate base_env
python $1
