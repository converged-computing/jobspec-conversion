#!/bin/bash
#FLUX: --job-name=milky-hope-3061
#FLUX: --urgency=16

srun singularity exec --nv ../images/bark_ml.img python3 -u ./configuration 
