#!/bin/bash
#FLUX: --job-name=joyous-carrot-3098
#FLUX: -t=82800
#FLUX: --priority=16

module load singularity
singularity exec marea_python.sif python ../scripts/post_process.py \
-p /projects/robinson-lab/marea/pubtator/current -r /projects/robinson-lab/marea/data/pubmed_rel \
-n /projects/robinson-lab/marea/data/nltk_data -o /projects/robinson-lab/marea/data/pubmed_cr/new
