#!/bin/bash
#FLUX --job-name=stinky-eagle-5124
#FLUX -c=4
#FLUX --urgency=16

srun singularity exec --nv ../images/bark_ml.img python3 -u ./configuration 
