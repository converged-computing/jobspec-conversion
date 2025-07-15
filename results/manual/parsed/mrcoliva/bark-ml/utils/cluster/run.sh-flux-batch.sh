#!/bin/bash
#FLUX: --job-name=hanky-parsnip-9907
#FLUX: --priority=16

srun singularity exec --nv ../images/bark_ml.img python3 -u ./configuration 
