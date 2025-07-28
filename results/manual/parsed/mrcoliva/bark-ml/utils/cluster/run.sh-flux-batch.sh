#!/bin/bash
#FLUX: --job-name=hairy-gato-8800
#FLUX: -c=4
#FLUX: --urgency=16

srun singularity exec --nv ../images/bark_ml.img python3 -u ./configuration 
