#!/bin/bash
#FLUX: --job-name=milky-milkshake-7667
#FLUX: --urgency=16

module load Anaconda3/5.0.1-fasrc02
source activate base_env
python $1
