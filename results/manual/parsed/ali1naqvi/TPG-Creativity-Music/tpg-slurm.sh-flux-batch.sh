#!/bin/bash
#FLUX --job-name=cowy-underoos-3137
#FLUX -t=259800
#FLUX --urgency=16

seed=$1
module load python/3.10
python models/generator_TPG.PY -s $seed  --num_proc 64
